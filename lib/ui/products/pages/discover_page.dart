

import 'package:article_hub/core/utils/dependency_injector.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_bloc.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_event.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.0),
        Divider(height: 1.0, color: Colors.grey[400]),
        Expanded(
          child: BlocProvider<RemoteProductsBloc>(
            create: (context) => dependencyInjector<RemoteProductsBloc>()..add(GetProductsEvent()),
            child: BlocListener<RemoteProductsBloc, RemoteProductsState>(
              listener: (context, state) {
                if (state is RemoteProductsFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed Getting Articles'), backgroundColor: Colors.red),
                  );
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
        if (state is RemoteProductsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is RemoteProductsSuccess) {
          if (state.products!.isNotEmpty) {
            return _buildArticles(state.products!);
          } else {
            return Center(child: Text("test"));
          }
        } else {
          return Center(child: Placeholder());
        }
      }
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
            )
          );
        }
    );
  }
}
