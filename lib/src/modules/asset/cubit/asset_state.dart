part of 'asset_cubit.dart';

sealed class AssetState extends Equatable {
  const AssetState() : datas = const [];
  final List<dynamic> datas;

  @override
  List<Object> get props => [datas];
}

final class AssetInitial extends AssetState {}

final class AssetLoading extends AssetState {}

final class AssetLoaded extends AssetState {
  final List<dynamic> dataList;

  AssetLoaded({required this.dataList}) {
    super.datas.clear();
    super.datas.addAll(dataList);
  }
}

final class AssetError extends AssetState {
  final String? message;
  const AssetError({this.message});
}
