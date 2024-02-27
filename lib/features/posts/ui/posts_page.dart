import 'package:bloc_api/features/posts/bloc/posts_bloc.dart';
import 'package:bloc_api/features/posts/ui/post_add_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    postsBloc.add(PostsInitialEvent());
    super.initState();
  }

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  final postsBloc = PostsBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.grey.shade100,
        onPressed: () {
          postsBloc.add(PostShowBottomSheetEvent());
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listener: (context, state) {
          if (state is PostAddActionState) {
            addPostBottomSheet(
              context,
              titleController,
              bodyController,
              postsBloc,
            );
          } else if (state is PostAddedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Post Added"),
              ),
            );
          } else if (state is PostNotAddedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Post Not Added"),
              ),
            );
          }
        },
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostsSuccessState:
              final successState = state as PostsSuccessState;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.grey,
                    expandedHeight: MediaQuery.sizeOf(context).height * 0.08,
                    floating: true,
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text("P O S T"),
                      titlePadding: EdgeInsets.all(20),
                      centerTitle: true,
                    ),
                    // bottom: AppBar(
                    //   title: Container(
                    //     height: 45,
                    //     child: TextField(
                    //       decoration: InputDecoration(
                    //           border: OutlineInputBorder(),
                    //           hintText: 'Enter a search term'),
                    //     ),
                    //   ),
                    // ),
                  ),
                  SliverList(delegate: SliverChildListDelegate([])),
                  SliverList.builder(
                    itemCount: successState.postsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      successState.postsList[index].title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Text(successState.postsList[index].id
                                      .toString()),
                                ],
                              ),
                              Text(successState.postsList[index].body),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            case PostsErrorState:
              final errorState = state as PostsErrorState;
              return Center(
                child: Text(errorState.error),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
