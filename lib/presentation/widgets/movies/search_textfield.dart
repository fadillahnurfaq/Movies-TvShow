import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class SearchTextField extends StatelessWidget {
  final VoidCallback onTap;
  const SearchTextField({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: TextField(
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          filled: true,
          fillColor: kGreySoftColor,
          hintText: "Search",
          suffixIcon: const Icon(
            Icons.search,
            color: kGreyColor,
          ),
          contentPadding: const EdgeInsets.all(15.0),
          border: _borders(),
          enabledBorder: _borders(),
          focusedBorder: _borders(),
          disabledBorder: _borders(),
        ),
      ),
    );
  }

  _borders() {
    return const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
    );
  }
}
