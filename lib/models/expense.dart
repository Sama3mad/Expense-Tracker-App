import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Category {food, travel, leisure, work}
//a collection of constant values

final formatter = DateFormat.yMd();

const categoryIcons = {
Category.food : Icons.fastfood,
Category.travel : Icons.flight_class_sharp,
Category.leisure: Icons.movie,
Category.work : Icons.work,
};
//map
const uuid = Uuid();
class Expense{
  Expense({
    required this.title, 
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; 


  String get formattedDate{
    return formatter.format(date);
    //formatter: This refers to the DateFormat object that you instantiated earlier with DateFormat.yMd().
  }
  //a getter function is defined like this
}