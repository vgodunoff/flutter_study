import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../pagination/post.dart';
import '../pagination/post_item.dart';

class PostsOverviewScreen extends StatefulWidget {
  @override
  _PostsOverviewScreenState createState() => _PostsOverviewScreenState();
}

class _PostsOverviewScreenState extends State<PostsOverviewScreen> {
  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 10;
  late List<Post> _posts;
  final int _nextPageTrigger = 1;

  @override
  void initState() {
    super.initState();
    _pageNumber = 0;
    _posts = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await get(Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_page=$_pageNumber&_limit=$_numberOfPostsPerRequest"));
      List responseList = json.decode(response.body);
      List<Post> postList = responseList
          .map((data) => Post(data['title'], data['body']))
          .toList();

      setState(() {
        _isLastPage = postList.length < _numberOfPostsPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _posts.addAll(postList);
      });
    } catch (e) {
      print("error --> $e");
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  Widget errorDialog({required double size}) {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An error occurred when fetching the posts.',
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _loading = true;
                  _error = false;
                  fetchData();
                });
              },
              child: const Text(
                "Retry",
                style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        centerTitle: true,
      ),
      body: buildPostsView(),
    );
  }

  Widget buildPostsView() {
    if (_posts.isEmpty) {
      //если список постов пустой то будет отрисован либо индикатор загрузки
      // или сообщение об ошибке
      if (_loading) {
        return const Center(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(child: errorDialog(size: 20));
      }
    }
    // если же в списке есть элементы, то рисуем их
    return ListView.builder(
        // itemCount - количество отображаемых элементов
        //он равен количеству постов и + 1
        //+1 - чтобы внизу постов отобразить индикатор загрузки или сообщение об ошибке
        itemCount: _posts.length + (_isLastPage ? 0 : 1),
        itemBuilder: (context, index) {
          if (index == _posts.length - _nextPageTrigger) {
//когда индекс ListView.builder дойдет почти до конца списка постов
//например, если 10 постов в списке, минус _nextPageTrigger (3)
//10-3 = 7
//когда доходим до 7 поста из 10, начинаем подгружать заранее следующую часть данных
//(следующие 10 постов)

            fetchData();
          }
          if (index == _posts.length) {
// когда дошли до конца списка отображаем индикатор загрузки или сообщение об ошибке
            if (_error) {
              return Center(child: errorDialog(size: 15));
            } else {
              debugPrint('$index');
              print(index);
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ));
            }
          }
//так как в initState() запускается метод fetchData(), то у нас уже имеется список
//постов, поэтому декларируем переменную типа Пост и присваиваем значение, берем по
//индексу объект из списка _posts. и далее работаем с этим объектом.
// такой подход улучшает производительность,
          //чем если бы мы каждый раз обращались к списку _posts[index]
          //то есть PostItem(_posts[index].title, _posts[index].body))
          final Post post = _posts[index];
          return Padding(
              padding: const EdgeInsets.all(15.0),
              child: PostItem(post.title, post.body));
        });
  }
}
