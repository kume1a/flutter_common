import 'package:flutter/material.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, int index, T item);
