import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/features/search/repository/seach_repository.dart';
import 'package:tracker/model/user_model.dart';

final searchControllerProvider = StateNotifierProvider(
  (ref) => SearchController(
    searchRepository: ref.read(searchRepositoryProvider),
    ref: ref,
  ),
);

final addFriendProvider = StreamProvider.family((ref, String query) {
  final searchController = ref.read(searchControllerProvider.notifier);
  return searchController.searhUser(query);
});

class SearchController extends StateNotifier<bool> {
  final SearchRepository _searchRepository;
  final Ref _ref;

  SearchController(
      {required SearchRepository searchRepository, required Ref ref})
      : _searchRepository = searchRepository,
        _ref = ref,
        super(false);
  Stream<List<UserModel>> searhUser(String query) {
    return _searchRepository.searchUser(query);
  }
}
