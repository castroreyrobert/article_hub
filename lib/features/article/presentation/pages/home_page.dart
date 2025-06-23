

import 'package:article_hub/core/utils/dependency_injector.dart';
import 'package:article_hub/features/article/domain/entities/article_entity.dart';
import 'package:article_hub/features/article/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:article_hub/features/article/presentation/bloc/remote/remote_articles_event.dart';
import 'package:article_hub/features/article/presentation/bloc/remote/remote_articles_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocProvider<RemoteArticleBloc>(
        create: (context) => dependencyInjector<RemoteArticleBloc>()..add(GetArticlesEvent()),
        child: BlocListener<RemoteArticleBloc, RemoteArticleState>(
          listener: (context, state) {
            if (state is RemoteArticleFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed Getting Articles'), backgroundColor: Colors.red),
              );
            }
          },
          child: _buildContent()
        )
      )

    );
  }

  Widget _buildContent() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (context, state) {
        if (state is RemoteArticleLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is RemoteArticleSuccess) {
          if (state.articles!.isNotEmpty) {
            return _buildArticles(state.articles!);
          } else {
            return Center(child: Text("test"));
          }
        } else {
          return Center(child: Placeholder());
        }
      }
    );
  }

  Widget _buildArticles(List<ArticleEntity> articles) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            title: Text(article.title!),
            subtitle: Text(article.url!),
          );
        }
    );
  }
}
