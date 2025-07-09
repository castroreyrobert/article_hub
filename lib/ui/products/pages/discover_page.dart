

import 'package:article_hub/core/utils/dependency_injector.dart';
import 'package:article_hub/data/models/products/product_category_model.dart';
import 'package:article_hub/domain/entities/products/product_category_entity.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_bloc.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_event.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_state.dart';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: BlocProvider<RemoteProductsBloc>(
            create: (context) => dependencyInjector<RemoteProductsBloc>()..add(GetProductsCategoriesEvent()),
            child: BlocListener<RemoteProductsBloc, RemoteProductsState>(
              listener: (context, state) {

                if (state is RemoteProductCategorySuccess) {
                  context.read<RemoteProductsBloc>().add(GetProductsEvent(null));
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
              },
              child: _buildContent()
            )
          ),
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
                  Expanded(child: _buildArticles(products ?? List.empty()))
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
                    context.read<RemoteProductsBloc>().add(GetProductsEvent(category.slug != ProductCategoryEntity.all.slug ? category.slug : null));
                },
              )
          );
        }
      ),
    );
  }

  Widget _buildArticles(List<ProductEntity> productList) {
    return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: productList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.8
        ),
        itemBuilder: (context, index) {
          final product = productList[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/product-details', arguments: product.id);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(product.thumbnail ?? "", fit: BoxFit.cover),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(product.title ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 4.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('₱${product.price}' ?? ""),
                  ),
                  SizedBox(height: 4.0),
                ]
              ),
            )
          );
        }
    );
  }
}
