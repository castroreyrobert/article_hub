

import 'package:article_hub/core/utils/dependency_injector.dart';
import 'package:article_hub/features/article/domain/entities/article_entity.dart';
import 'package:article_hub/features/article/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:article_hub/features/article/presentation/bloc/remote/remote_articles_event.dart';
import 'package:article_hub/features/article/presentation/bloc/remote/remote_articles_state.dart';
import 'package:article_hub/features/products/domain/entities/product_entity.dart';
import 'package:article_hub/features/products/presentation/bloc/remote/remote_products_bloc.dart';
import 'package:article_hub/features/products/presentation/bloc/remote/remote_products_event.dart';
import 'package:article_hub/features/products/presentation/bloc/remote/remote_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text("Home Page", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
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
      )

    );
  }

  Widget _buildContent() {
    return BlocBuilder<RemoteProductsBloc, RemoteProductsState>(
      builder: (context, state) {
        if (state is RemoteArticleLoading) {
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

  Widget _buildArticles(List<ProductEntity> articles) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            title: Text(article.title!),
            subtitle: Text(article.description!),
          );
        }
    );
  }
}
