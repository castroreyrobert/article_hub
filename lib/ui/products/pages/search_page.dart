import 'package:article_hub/core/utils/dependency_injector.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_bloc.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_event.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _queryController = TextEditingController();

  final RemoteProductsBloc _remoteProductsBloc = dependencyInjector<RemoteProductsBloc>();

  @override
  void initState() {
    _queryController.addListener(() {
      setState(() {
        if (_queryController.text.isNotEmpty) {
          Future.delayed(Duration(seconds: 2), () {
            _remoteProductsBloc.add(
                GetProductsEvent(query: _queryController.text));
          });
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
            child: BlocProvider<RemoteProductsBloc>(
              create: (context) => _remoteProductsBloc,
              child: BlocListener<RemoteProductsBloc, RemoteProductsState>(
                listener: (context, state) {
                  if (state is RemoteProductsFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed Getting Articles'),
                          backgroundColor: Colors.red),
                    );
                  }
                },
                child: _buildContent()
              )
            )
          )
        ]
      ),
    );
  }

  Widget _buildContent() {
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

  Widget _buildSearchProductResults(List<ProductEntity> results) {
    return ListView.builder(
      itemCount: results.length,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(16),
      itemBuilder: (ctx, index)  {
        final product = results[index];
        return Row(
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
        );
      }
    );
  }
}
