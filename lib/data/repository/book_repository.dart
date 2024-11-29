import 'dart:convert';

import 'package:flutter_book_search_app/data/model/book.dart';
import 'package:http/http.dart';

class BookRepository {
  Future<List<Book>> searchBook(String query) async {
    final client = Client();
    final response = await client.get(
      Uri.parse('https://openapi.naver.com/v1/search/book.json?query=$query'),
      headers: {
        'X-Naver-Client-Id': 'mi3hF2nK1xUcIloccuXG',
        'X-Naver-Client-Secret': '7012_bneD5',
      },
    );
    //get 요청 시 성공 => 200
    //응답 코드가 200일 때 body 데이터를 jsonDecoder 함수 사용해서 map으로 바꾼 뒤 List<Book>으로 반환
    //응답 코드가 200이 아닐 때 빈 리스트로 반환
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      final items = List.from(map['items']);
      final iterable = items.map(
        (e) {
          return Book.fromJson(e);
        },
      );

      final list = iterable.toList();
      return list;
    }

    return [];
  }
}
