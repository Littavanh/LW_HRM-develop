import 'package:flutter/material.dart';

class InstantSearchPage extends SearchDelegate {
  dynamic selectedResult;
  final List<dynamic> _optionList;
  
  final String _title;
  final IconData _itemIcon;

  InstantSearchPage(this._optionList, this._title, this._itemIcon);

  @override
  String get searchFieldLabel => _title;

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult.name),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> suggestionList = [];

    print(_itemIcon);

    query.isEmpty
        ? suggestionList = _optionList
        : suggestionList
            .addAll(_optionList.where((element) => element.contains(query)));

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              suggestionList[index],
            ),
            leading: (query.isEmpty && _itemIcon == null)
                ? SizedBox()
                : Icon(_itemIcon),
            onTap: () {
              selectedResult = suggestionList[index];
              close(context, selectedResult);
            },
          );
        });
  }
}
