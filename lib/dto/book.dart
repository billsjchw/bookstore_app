import 'package:flutter/material.dart';

class Book {
  final int id;
  final String isbn;
  final String title;
  final String author;
  final String lang;
  final String press;
  final DateTime date;
  final int price;
  final int stock;
  final Cover cover;
  final Introduction intro;

  Book({
    @required this.id,
    @required this.isbn,
    @required this.title,
    @required this.author,
    @required this.lang,
    @required this.press,
    @required this.date,
    @required this.price,
    @required this.stock,
    @required this.cover,
    @required this.intro,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      isbn: json['isbn'],
      title: json['title'],
      author: json['author'],
      lang: json['lang'],
      press: json['press'],
      date: DateTime.parse(json['date']),
      price: json['price'],
      stock: json['stock'],
      cover: Cover.fromJson(json['cover']),
      intro: Introduction.fromJson(json['intro']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'isbn': isbn,
      'title': title,
      'author': author,
      'lang': lang,
      'press': press,
      'date': date.toIso8601String(),
      'price': price,
      'stock': stock,
      'cover': cover.toJson(),
      'intro': intro.toJson(),
    };
  }

  @override
  bool operator ==(other) => other is Book && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class Cover {
  final int bookId;
  final String data;

  Cover({
    @required this.bookId,
    @required this.data,
  });

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      bookId: json['bookId'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'bookId': bookId,
      'data': data,
    };
  }

  @override
  bool operator ==(other) {
    return other is Cover && other.bookId == bookId;
  }

  @override
  int get hashCode => bookId.hashCode;
}

class Introduction {
  final int bookId;
  final String data;

  Introduction({
    @required this.bookId,
    @required this.data,
  });

  factory Introduction.fromJson(Map<String, dynamic> json) {
    return Introduction(
      bookId: json['bookId'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'bookId': bookId,
      'data': data,
    };
  }

  @override
  bool operator ==(other) {
    return other is Introduction && other.bookId == bookId;
  }

  @override
  int get hashCode => bookId.hashCode;
}
