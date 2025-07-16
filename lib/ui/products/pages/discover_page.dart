

import 'package:article_hub/core/utils/app_routes.dart';
import 'package:article_hub/core/utils/dependency_injector.dart';
import 'package:article_hub/domain/entities/products/product_category_entity.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_bloc.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_event.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/local/local_products_bloc.dart';
import '../bloc/local/local_products_event.dart';
import '../bloc/local/local_products_state.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  ProductCategoryEntity selectedCategory = ProductCategoryEntity.all;

  var categoryList = [ProductCategoryEntity.all];


  @override
  void dispose() {
    selectedCategory = ProductCategoryEntity.all;
    super.dispose();
  }

  void onAddAllCategory(List<ProductCategoryEntity> categoryList) {
    setState(() {
      this.categoryList = categoryList;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.0),
        Divider(height: 1.0, color: Colors.grey[400]),
        Expanded(
          child: MultiBlocProvider(
              providers: [
                BlocProvider<RemoteProductsBloc>(
                    create: (context) => dependencyInjector<RemoteProductsBloc>()..add(GetProductsCategoriesEvent()),
                ),
                BlocProvider<LocalProductsBloc>(
                  create: (context) => dependencyInjector<LocalProductsBloc>(),
                ),
              ],
              child: MultiBlocListener(
                listeners: [
                  BlocListener<RemoteProductsBloc, RemoteProductsState>(
                    listener: (context, state) {
                      if (state is RemoteProductCategorySuccess) {
                        context.read<RemoteProductsBloc>().add(GetProductsEvent());
                      }
                      if (state is RemoteProductsFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed Getting Articles'), backgroundColor: Colors.red),
                        );
                      }
                      else {
                        if (state.categories != null) {
                          final categories = state.categories!.map((e) =>
                              ProductCategoryEntity(slug: e.slug, name: e.name, url: e.url)).toList();
                          final productCategories = [ProductCategoryEntity.all, ...categories];
                          onAddAllCategory(productCategories);
                        }
                      }
                    }
                  ),
                  BlocListener<LocalProductsBloc, LocalProductState>(
                    listener: (context, state) {
                      if (state is LocalProductFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed Getting Articles'),
                              backgroundColor: Colors.red),
                        );
                      } else if (state is LocalProductGenericSuccess) {
                        context.read<RemoteProductsBloc>().add(UpdateProductDetailsEvent());
                      }
                    }
                  )
                ], child: _buildContent(),
              )
          )
        ),
      ],
    );
  }

  Widget _buildContent() {
    return BlocBuilder<RemoteProductsBloc, RemoteProductsState>(
      builder: (context, state) {
          final List<ProductEntity> ? products = state.products;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              spacing: 8.0,
              children: [
                SizedBox(height: 8.0),
                _buildCategories(categoryList),
                if (state is RemoteProductsLoading)
                  Expanded(child: Center(child: CircularProgressIndicator()))
                else
                  Expanded(child: _buildProducts(products ?? List.empty()))
              ],
            ),
          );
      }
    );
  }

  Widget _buildCategories(List<ProductCategoryEntity> categories) {
    return SizedBox(
      height: 36.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: FilterChip(
                selected: isSelected,
                label: Text(category.name),
                showCheckmark: false,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
                onSelected: (bool value) {
                    setState(() {
                      selectedCategory = value ? category : ProductCategoryEntity.all;
                    });
                    context.read<RemoteProductsBloc>().add(GetProductsEvent(category: category.slug != ProductCategoryEntity.all.slug ? category.slug : null));
                },
              )
          );
        }
      ),
    );
  }

  Widget _buildProducts(List<ProductEntity> productList) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.7
      ),
      itemBuilder: (context, index) {
        final product = productList[index];

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          clipBehavior: Clip.antiAlias, // Good for ensuring content respects border radius
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.productDetails, arguments: product.id);
            },
            child: Column( // Main layout: Image then Text content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section (Flexible Height)
                Expanded( // Let the image section take up available vertical space
                  flex: 3,
                  child: Stack(
                    alignment: Alignment.center, // To center the image if it doesn't fill
                    fit: StackFit.expand, // Make Stack fill the Expanded space
                    children: <Widget>[
                      // Image itself
                      Image.network(
                        product.thumbnail ?? "https://via.placeholder.com/200",
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator(strokeWidth: 2.0));
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.broken_image, color: Colors.grey, size: 40));
                        },
                      ),
                      // Favorite Icon Overlay
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: GestureDetector(
                          onTap: () {
                            if(product.isFavorite) {
                              context.read<LocalProductsBloc>().add(RemoveFromFavoriteProductsEvent(product: product));
                            } else {
                            context.read<LocalProductsBloc>().add(AddToFavoriteProductsEvent(product: product));
                            }
                            // Update your state management here
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              (product.isFavorite ?? false) ? Icons.favorite : Icons.favorite_border,
                              color: (product.isFavorite ?? false) ? Colors.redAccent : Colors.white,
                              size: 22.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Text Section
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Important: Column should only take needed vertical space for text
                    children: [
                      Text(
                        product.title ?? "No Title",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        maxLines: 2, // Allow up to 2 lines for title
                        overflow: TextOverflow.ellipsis, // Show '...' if title is longer
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '₱${product.price?.toStringAsFixed(2) ?? "N/A"}',
                        style: const TextStyle(fontSize: 13, color: Colors.deepOrange),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
