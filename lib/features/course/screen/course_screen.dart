import 'package:flutter/material.dart';
import 'package:smallbytes/core/constant/colors.dart';
import 'package:smallbytes/core/models/user_model.dart';
import 'package:smallbytes/core/widget/cutom_card.dart';
import 'package:smallbytes/features/course/models/course.dart';
import 'package:smallbytes/features/course/models/course_cache.dart';
import 'package:smallbytes/features/course/screen/single_course_screen.dart';
import 'package:smallbytes/features/course/service/course_service.dart';

class CourseScreen extends StatefulWidget {
  final UserModel? userModel;

  CourseScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}


class _CourseScreenState extends State<CourseScreen> {
  List<String> tags = ["All", "UI/UX", "Programming", "Design", "Marketing", "Data Science"];
  final CourseService _courseService = CourseService();
  final CourseCache _courseCache = CourseCache();
  final int _limit = 10;
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    if (_courseCache.cachedCourses.isEmpty) {
      _fetchCourses();
    }
  }




  Future<void> _fetchCourses() async {
    if (_isLoading || !_courseCache.hasMore) return;

    setState(() {
      _isLoading = true;
    });

    List<Course> fetchedCourses = await _courseService.getCourses(limit: _limit, offset: _courseCache.offset);

    setState(() {
      _courseCache.cachedCourses.addAll(fetchedCourses);
      _courseCache.offset += _limit;
      _courseCache.hasMore = fetchedCourses.length == _limit;
      _isLoading = false;
    });
  }
  Future<void> _refreshCourses() async {
    _courseCache.cachedCourses.clear();
    _courseCache.offset = 0;
    _courseCache.hasMore = true;
    await _fetchCourses();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: CustomColors.primary,
        onRefresh: _refreshCourses,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello,",
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Text(
                              widget.userModel?.name ?? "User",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.notifications_none, color: CustomColors.primary),
                          onPressed: () {
                            // Handle notifications
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search courses",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tags.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: ChoiceChip(
                          label: Text(tags[index]),
                          selected: index == 0,
                          onSelected: (bool selected) {
                            // Handle tag selection
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              _courseCache.cachedCourses.isEmpty
                  ? SliverToBoxAdapter(
                child: Center(child: Text("No courses found")),
              )
                  : SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      if (index >= _courseCache.cachedCourses.length - 1 && _courseCache.hasMore) {
                        _fetchCourses();
                      }
                      return CourseCard(
                        imgUrl: "https://images.unsplash.com/photo-1518773553398-650c184e0bb3",
                        length: "30m",
                        name: _courseCache.cachedCourses[index].name,
                        description: _courseCache.cachedCourses[index].description,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SingleCourseScreen(course: _courseCache.cachedCourses[index])),
                          );
                        },
                      );
                    },
                    childCount: _courseCache.cachedCourses.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String imgUrl;
  final String length;
  final String name;
  final String description;
  final VoidCallback onPressed;

  const CourseCard({
    Key? key,
    required this.imgUrl,
    required this.length,
    required this.name,
    required this.description,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imgUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: CustomColors.primary),
                      SizedBox(width: 4),
                      Text(length, style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}