import 'package:get_it/get_it.dart';
import 'package:intexgram/Data/datasources/comment_remote_datasource.dart';
import 'package:intexgram/Data/datasources/local_datasource.dart';
import 'package:intexgram/Data/datasources/person_remote_datasource.dart';
import 'package:intexgram/Data/datasources/post_remote_datasource.dart';
import 'package:intexgram/Data/repositories/comments_repository_impl.dart';
import 'package:intexgram/Data/repositories/person_repository_impl.dart';
import 'package:intexgram/Data/repositories/post_repository_impl.dart';
import 'package:intexgram/Domain/repositories/comments_repository.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/Domain/repositories/post_repository.dart';
import 'package:intexgram/Domain/usecases/comments_use_cases/add_comment_use_case.dart';
import 'package:intexgram/Domain/usecases/comments_use_cases/get_comments_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/change_photo_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/chek_subscription_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_all_persons_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_current_person_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_persons_from_collection_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/set_current_person_use_case.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/update_current_person_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/add_to_favorite_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/create_post_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/get_favorite_posts_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/get_post_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/get_user_posts_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/remove_from_favorite_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/remove_like_use_case.dart';
import 'package:intexgram/Domain/usecases/post_use_cases/set_like_use_case.dart';
import 'package:intexgram/Presentation/Routes/auth_guard.dart';
import 'package:intexgram/core/platform/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Domain/usecases/person_use_cases/subscribe_use_case.dart';
import 'Domain/usecases/person_use_cases/un_subscribe_use_case.dart';
import 'Presentation/Routes/router.gr.dart';

final serverLocator = GetIt.instance;

Future<void> init() async {
  //UseCases
  //Person
  serverLocator
      .registerLazySingleton(() => ChangePhotoUseCase(serverLocator()));

  serverLocator
      .registerLazySingleton(() => CheckSubscriptionUseCase(serverLocator()));

  serverLocator
      .registerLazySingleton(() => GetAllPersonsUseCase(serverLocator()));

  serverLocator
      .registerLazySingleton(() => GetCurrentPersonUseCase(serverLocator()));

  serverLocator.registerLazySingleton(
      () => GetPersonsFromCollectionUseCase(serverLocator()));

  serverLocator
      .registerLazySingleton(() => SetCurrentPersonUseCase(serverLocator()));

  serverLocator.registerLazySingleton(() => SubscribeUseCase(serverLocator()));
  serverLocator
      .registerLazySingleton(() => UnSubscribeUseCase(serverLocator()));

  serverLocator
      .registerLazySingleton(() => UpdateCurrentPersonUseCase(serverLocator()));

  //Post
  serverLocator
      .registerLazySingleton(() => AddToFavoriteUseCase(serverLocator()));

  serverLocator.registerLazySingleton(() => CreatePostUseCase(serverLocator()));

  serverLocator
      .registerLazySingleton(() => GetFavoritePostsUseCase(serverLocator()));

  serverLocator.registerLazySingleton(() => GetPostUseCase(serverLocator()));

  serverLocator
      .registerLazySingleton(() => GetUserPostsUseCase(serverLocator()));

  serverLocator
      .registerLazySingleton(() => RemoveFromFavoriteUseCase(serverLocator()));

  serverLocator.registerLazySingleton(() => RemoveLikeUseCase(serverLocator()));

  serverLocator.registerLazySingleton(() => SetLikeUseCase(serverLocator()));

  //Comment
  serverLocator.registerLazySingleton(() => AddCommentUseCase(serverLocator()));

  serverLocator
      .registerLazySingleton(() => GetCommentsUseCase(serverLocator()));

  //Repository
  serverLocator.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      localDataSource: serverLocator(),
      personRemoteDataSource: serverLocator(),
      networkInfo: serverLocator(),
    ),
  );

  serverLocator.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      networkInfo: serverLocator(),
      localDataSource: serverLocator(),
      postRemoteDataSource: serverLocator(),
    ),
  );
  serverLocator.registerLazySingleton<CommentsRepository>(
    () => CommentsRepositoryImpl(
      networkInfo: serverLocator(),
      commentRemoteDataSource: serverLocator(),
    ),
  );

  serverLocator.registerLazySingleton<PersonRemoteDataSource>(
      () => PersonRemoteDataSourceImpl());
  serverLocator.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl());
  serverLocator.registerLazySingleton<CommentRemoteDataSource>(
      () => CommentRemoteDataSourceImpl());

  serverLocator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: serverLocator()));

  //Core
  serverLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //Routes
  final flutterRouter = FlutterRouter(authGuard: AuthGuard());
  serverLocator.registerLazySingleton(() => flutterRouter);

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  serverLocator.registerLazySingleton(() => sharedPreferences);
}
