import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showSearch;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchToggle;
  final bool isSearching;
  final TextEditingController? searchController;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showSearch = false,
    this.onSearchChanged,
    this.onSearchToggle,
    this.isSearching = false,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title:
          isSearching
              ? TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  hintStyle: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onPrimary.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                autofocus: true,
              )
              : Text(title),
      actions: [
        if (showSearch)
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: onSearchToggle,
          ),
        if (actions != null) ...actions!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SliverCustomAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final bool showSearch;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchToggle;
  final bool isSearching;
  final TextEditingController? searchController;
  final Widget? flexibleSpace;

  const SliverCustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showSearch = false,
    this.onSearchChanged,
    this.onSearchToggle,
    this.isSearching = false,
    this.searchController,
    this.flexibleSpace,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title:
          isSearching
              ? TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onPrimary.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                autofocus: true,
              )
              : Text(title),
      actions: [
        if (showSearch)
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: onSearchToggle,
          ),
        if (actions != null) ...actions!,
      ],
      floating: true,
      snap: true,
      flexibleSpace: flexibleSpace,
    );
  }
}
