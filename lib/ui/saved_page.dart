
import 'package:article_hub/ui/home_page.dart';
import 'package:article_hub/ui/products/bloc/local/local_products_bloc.dart';
import 'package:article_hub/ui/products/bloc/local/local_products_event.dart';
import 'package:article_hub/ui/products/bloc/local/local_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/app_routes.dart';
import '../core/utils/dependency_injector.dart';
import '../domain/entities/products/product_entity.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.0),
        Divider(height: 1.0, color: Colors.grey[400]),
        Expanded(
            child: BlocProvider<LocalProductsBloc>(
              create: (context) => dependencyInjector<LocalProductsBloc>()..add(GetFavoriteProductsEvent()),
                child: BlocListener<LocalProductsBloc, LocalProductState>(
                  listener: (context, state) {
                    if (state is LocalProductGenericSuccess) {
                      context.read<LocalProductsBloc>().add(GetFavoriteProductsEvent());
                    }
                  },
                  child: _buildContent(),
                )
            )
        ),
      ],
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
                              context.read<LocalProductsBloc>().add(
                                  AddToFavoriteProductsEvent(product: product));
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

  Widget _buildContent() {
    return BlocBuilder<LocalProductsBloc, LocalProductState>(
        builder: (context, state) {
          final List<ProductEntity> ? products = state.favoriteProducts;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              spacing: 8.0,
              children: [
                SizedBox(height: 8.0),
                if (state is LocalProductLoading)
                  Expanded(child: Center(child: CircularProgressIndicator()))
                else
                  Expanded(child: _buildProducts(products ?? List.empty()))
              ],
            ),
          );
        }
    );
  }
}