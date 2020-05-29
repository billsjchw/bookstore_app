import 'package:flutter/material.dart';

class Book {
  final String isbn;
  final String title;
  final String author;
  final String language;
  final String press;
  final DateTime date;
  final int price;
  final int stock;
  final Cover cover;
  final Introduction introduction;

  Book({
    @required this.isbn,
    @required this.title,
    @required this.author,
    @required this.language,
    @required this.press,
    @required this.date,
    @required this.price,
    @required this.stock,
    @required this.cover,
    @required this.introduction,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      isbn: json['isbn'],
      title: json['title'],
      author: json['author'],
      language: json['language'],
      press: json['press'],
      date: DateTime.parse(json['date']),
      price: json['price'],
      stock: json['stock'],
      cover: Cover.fromJson(json['cover']),
      introduction: Introduction.fromJson(json['introduction']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'isbn': isbn,
      'title': title,
      'author': author,
      'language': language,
      'press': press,
      'date': date.toIso8601String(),
      'price': price,
      'stock': stock,
      'cover': cover.toJson(),
      'introduction': introduction.toJson(),
    };
  }

  @override
  bool operator ==(other) => other is Book && other.isbn == isbn;

  @override
  int get hashCode => isbn.hashCode;
}

class Cover {
  final String isbn;
  final String data;

  Cover({this.isbn, this.data});

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      isbn: json['isbn'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'isbn': isbn,
      'data': data,
    };
  }

  @override
  bool operator ==(other) => other is Cover && other.isbn == isbn;

  @override
  int get hashCode => isbn.hashCode;
}

class Introduction {
  final String isbn;
  final String data;

  Introduction({this.isbn, this.data});

  factory Introduction.fromJson(Map<String, dynamic> json) {
    return Introduction(
      isbn: json['isbn'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'isbn': isbn,
      'data': data,
    };
  }

  @override
  bool operator ==(other) => other is Introduction && other.isbn == isbn;

  @override
  int get hashCode => isbn.hashCode;
}
