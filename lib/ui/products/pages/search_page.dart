import 'package:article_hub/core/utils/app_routes.dart';
import 'package:article_hub/core/utils/dependency_injector.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:article_hub/ui/products/bloc/local/local_products_bloc.dart';
import 'package:article_hub/ui/products/bloc/local/local_products_event.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_bloc.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_event.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/local/local_products_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _queryController = TextEditingController();

  final RemoteProductsBloc _remoteProductsBloc = dependencyInjector<RemoteProductsBloc>();
  final LocalProductsBloc _localProductsBloc = dependencyInjector<LocalProductsBloc>();

  @override
  void initState() {
    _queryController.addListener(() {
      setState(() {
        if (_queryController.text.isNotEmpty) {
          _remoteProductsBloc.add(
              GetProductsEvent(query: _queryController.text));
        } else {
          _localProductsBloc.add(GetRecentProductsEvent());
        }
      }); // Update the UI when the text changes
    });
    super.initState();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CupertinoSearchTextField(
              controller: _queryController
          ),
          Expanded(
            child: MultiBlocProvider(
              providers: [
                BlocProvider<RemoteProductsBloc>(
                  create: (context) => _remoteProductsBloc,
                ),
                BlocProvider<LocalProductsBloc>(
                  create: (context) => _localProductsBloc..add(GetRecentProductsEvent()),
                ),
              ],
              child: MultiBlocListener(
                  listeners: [
                    BlocListener<RemoteProductsBloc, RemoteProductsState>(
                        listener: (context, state) {
                          if (state is RemoteProductsFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed Getting Articles'),
                                  backgroundColor: Colors.red),
                            );
                          }
                        },
                    ),

                    BlocListener<LocalProductsBloc, LocalProductState>(
                      listener: (context, state) {
                        if (state is LocalProductFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed Getting Articles'),
                                backgroundColor: Colors.red),
                          );
                        }
                      },
                      child: _buildRecentProducts(),
                    )
                  ],
                  child: _buildBodyContent()
              )
            )
          )
        ]
      ),
    );
  }

  Widget _buildBodyContent() {
    if (_queryController.text.isEmpty) {
      return _buildRecentProducts();
    } else {
      return _buildSearchProductResultsContent();
    }
  }

  Widget _buildSearchProductResultsContent() {
    return BlocBuilder<RemoteProductsBloc, RemoteProductsState>(
      builder: (context, state) {
        final List<ProductEntity> ? products = state.products;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state is RemoteProductsLoading)
              Expanded(child: Center(child: CircularProgressIndicator()))
            else
              Expanded(child: _buildSearchProductResults(products ?? List.empty()))
          ],
        );
      }
    );
  }


  Widget _buildRecentProducts() {
    return BlocBuilder<LocalProductsBloc, LocalProductState>(
        builder: (context, state) {
          final List<ProductEntity> ? products = state.recentProducts;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Recent Searches", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                    GestureDetector(
                      onTap: () {
                        _localProductsBloc.add(ClearRecentProductsEvent());
                      },
                      child: Text("Clear All", style: TextStyle(decoration: TextDecoration.underline))
                    ),
                  ],
                ),
              ),
              if (state is RemoteProductsLoading)
                Expanded(child: Center(child: CircularProgressIndicator()))
              else
                Expanded(child: _buildRecentSearchProducts(products ?? List.empty()))
            ],
          );
        }
    );
  }

  Widget _buildRecentSearchProducts(List<ProductEntity> recent) {
    return ListView.builder(
        itemCount: recent.length,
        itemBuilder: (ctx, index) {
          final recentProduct = recent[index];
          return GestureDetector(
              onTap: (){
                Navigator.pushNamed(ctx, AppRoutes.productDetails, arguments: recentProduct.id);
              },
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded( child: Text(recentProduct.title ?? "")),
                          const Image(image: AssetImage('assets/images/close_circle.png'))
                        ]
                      ),
                    ),
                    Divider(height: 1.0, color: Colors.grey[400])
                  ],
                ),
              )
          );

    });
  }

  Widget _buildSearchProductResults(List<ProductEntity> results) {
    return ListView.builder(
      itemCount: results.length,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(16),
      itemBuilder: (ctx, index)  {
        final product = results[index];
        return InkWell(
          onTap: () {
            _localProductsBloc.add(AddToRecentProductsEvent(product: product));
            Navigator.pushNamed(ctx, AppRoutes.productDetails, arguments: product.id);
          },
          child: Row(
            children: [
              SizedBox(height: 56, width: 56, child: Image.network(product.thumbnail ?? "")),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('₱${product.price}')
                  ],
                ),
              )
            ]
          ),
        );
      }
    );
  }
}
