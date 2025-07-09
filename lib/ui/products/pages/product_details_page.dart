
import 'package:article_hub/core/utils/dependency_injector.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_bloc.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_event.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
      body: BlocProvider<RemoteProductsBloc>(
        create: (context) => dependencyInjector<RemoteProductsBloc>()..add(GetProductDetailsEvent(id: id)),
        child: BlocListener<RemoteProductsBloc, RemoteProductsState>(
          listener: (context, state) {
            if (state is RemoteProductsFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed Getting Articles'),
                    backgroundColor: Colors.red),
              );
            } else if (state is GetProductDetailsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Success Getting Articles'),
                    backgroundColor: Colors.green),
              );
            }
          },
          child: _buildProductDetailsContent()
        )
      )
    );
  }

  Widget _buildProductDetailsContent() {
    return BlocBuilder<RemoteProductsBloc, RemoteProductsState>(
      builder: (context, state) {
        return Padding(
            padding: EdgeInsetsGeometry.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              spacing: 8.0,
              children: [
                if (state is RemoteProductsLoading)
                  Expanded(child: Center(child: CircularProgressIndicator()))
                else
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Image.network(
                            state.productDetails?.images?.firstOrNull ?? "", fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Text(state.productDetails?.title ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.0),
                  Text('₱ ${state.productDetails?.price}' ?? ""),
              ]
            )
        );
      }
    );
  }
}
