import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List list = List();
  int _page = 1;
  ScrollController _scrollController =ScrollController();
  bool isLoading =false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _scrollController.addListener((){
      if(_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent ){
        print('滑动到底部');
      _getMore();
      }
    });
  }

  /// 初始化list数据 加延时模仿网络请求
  Future getData() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        list = List.generate(15, (i) => '数据 $i');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下拉'),
      ),
      body: RefreshIndicator(
          child: ListView.builder(
            itemBuilder: _renderRow,
            itemCount: list.length +1,
            controller: _scrollController,
          ),
          onRefresh: _onRefresh),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    if(index < list.length){
      return ListTile(
        title: Text(list[index]),
      );
    }
    return _getMoreWidget();
  }
  // ignore: slash_for_doc_comments
  /**
   * 下拉刷新方法,为list重新赋值
  */
  Future<Null> _onRefresh() async{
    await Future.delayed(Duration(seconds: 3), (){
      print('加载');
      setState(() {
        list = List.generate(20, (i) => "新数据 $i");
      });
    });
  }
  /**
   * 上拉加载更多
   */
  Future _getMore() async{
    if(!isLoading){
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1), (){
        print('加载更多');
        setState(() {
          list.addAll(List.generate(5, (i) => '$_page 上拉的数据'));
          _page ++;
          isLoading =false;
        });
      });
    }
  }
  /**
   * 加载更多时显示的组件,给用户提示
   */
  Widget _getMoreWidget(){
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16),
            ),
            CircularProgressIndicator(strokeWidth: 1,)
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}

