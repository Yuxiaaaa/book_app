import 'dart:convert';

import 'package:book_app/model/book_detail_response.dart';
import 'package:book_app/model/book_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import 'image_view_screen.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({super.key, required this.isbn});
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookDetailResponse? detailBook;
  fetchDetailBookApi() async {
    print(widget.isbn);
    var url = Uri.parse('https://api.itbook.store/1.0/books/${widget.isbn}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      setState(() {});
      fetchSimiliarBookApi(detailBook!.title!);
    }

    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  BookListResponse? similiarBook;
  fetchSimiliarBookApi(String title) async {
    print(widget.isbn);
    var url = Uri.parse('https://api.itbook.store/1.0/search/${title}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similiarBook = BookListResponse.fromJson(jsonDetail);
      setState(() {});
    }

    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetailBookApi();
  }

  @override
  Widget build(BuildContext context) {
    print(detailBook);
    return Scaffold(
        appBar: AppBar(title: Text(" Detail")),
        body: detailBook == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ImageViewScreen(
                                    imageUrl: detailBook!.image!)),
                              ),
                            );
                          },
                          child: Image.network(
                            detailBook!.image!,
                            height: 150,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(detailBook!.title!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(
                                  detailBook!.authors!,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: List.generate(
                                      5,
                                      (index) => Icon(Icons.star,
                                          color: index <
                                                  int.parse(detailBook!.rating!)
                                              ? Colors.yellow
                                              : Colors.grey)),
                                ),
                                Text(detailBook!.subtitle!,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(detailBook!.price!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              //fixedSize: Size(double.infinity, 50)
                              ),
                          onPressed: () {},
                          child: Text("Buy")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(detailBook!.desc!),
                    SizedBox(height: 5),
                    //OutlinedButton(onPressed: onPressed, child: child),
                    //TextButton(onPressed: onPressed, child: child),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Year: " + detailBook!.year!),
                        Text("ISBN" + detailBook!.isbn13!),
                        Text(detailBook!.pages! + "Page"),
                        Text("Publisher:" + detailBook!.publisher!),
                        Text("Language:" + detailBook!.language!),

                        //Text(detailBook!.rating!),
                      ],
                    ),
                    Divider(),
                    similiarBook == null
                        ? CircularProgressIndicator()
                        : Container(
                            height: 150,
                            child: ListView.builder(
                              //shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: similiarBook!.books!.length,
                              //physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final current = similiarBook!.books![index];
                                return Container(
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Image.network(
                                        current.image!,
                                        height: 100,
                                      ),
                                      Text(
                                        current.title!,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                  ],
                ),
              ));
  }
}
