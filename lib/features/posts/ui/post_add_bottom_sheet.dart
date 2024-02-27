import 'package:bloc_api/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';

void addPostBottomSheet(
  BuildContext context,
  TextEditingController titleController,
  TextEditingController bodyController,
  PostsBloc postsBloc,
) {
  showModalBottomSheet(
    backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Title",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: bodyController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    labelText: "Body",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        bodyController.text.isNotEmpty) {
                      postsBloc.add(
                        PostAddEvent(
                          title: titleController.text,
                          body: bodyController.text,
                        ),
                      );
                      Navigator.of(context).pop();
                      titleController.clear();
                      bodyController.clear();
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.grey),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
