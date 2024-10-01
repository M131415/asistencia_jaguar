// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getStudentsFromCSVHash() =>
    r'9939295640e9dd827f1ab1c4835511e44602959c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getStudentsFromCSV].
@ProviderFor(getStudentsFromCSV)
const getStudentsFromCSVProvider = GetStudentsFromCSVFamily();

/// See also [getStudentsFromCSV].
class GetStudentsFromCSVFamily extends Family<AsyncValue<List<StudentEntity>>> {
  /// See also [getStudentsFromCSV].
  const GetStudentsFromCSVFamily();

  /// See also [getStudentsFromCSV].
  GetStudentsFromCSVProvider call(
    List<StudentEntity> studentList,
  ) {
    return GetStudentsFromCSVProvider(
      studentList,
    );
  }

  @override
  GetStudentsFromCSVProvider getProviderOverride(
    covariant GetStudentsFromCSVProvider provider,
  ) {
    return call(
      provider.studentList,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getStudentsFromCSVProvider';
}

/// See also [getStudentsFromCSV].
class GetStudentsFromCSVProvider
    extends AutoDisposeFutureProvider<List<StudentEntity>> {
  /// See also [getStudentsFromCSV].
  GetStudentsFromCSVProvider(
    List<StudentEntity> studentList,
  ) : this._internal(
          (ref) => getStudentsFromCSV(
            ref as GetStudentsFromCSVRef,
            studentList,
          ),
          from: getStudentsFromCSVProvider,
          name: r'getStudentsFromCSVProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getStudentsFromCSVHash,
          dependencies: GetStudentsFromCSVFamily._dependencies,
          allTransitiveDependencies:
              GetStudentsFromCSVFamily._allTransitiveDependencies,
          studentList: studentList,
        );

  GetStudentsFromCSVProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentList,
  }) : super.internal();

  final List<StudentEntity> studentList;

  @override
  Override overrideWith(
    FutureOr<List<StudentEntity>> Function(GetStudentsFromCSVRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetStudentsFromCSVProvider._internal(
        (ref) => create(ref as GetStudentsFromCSVRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentList: studentList,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<StudentEntity>> createElement() {
    return _GetStudentsFromCSVProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetStudentsFromCSVProvider &&
        other.studentList == studentList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetStudentsFromCSVRef
    on AutoDisposeFutureProviderRef<List<StudentEntity>> {
  /// The parameter `studentList` of this provider.
  List<StudentEntity> get studentList;
}

class _GetStudentsFromCSVProviderElement
    extends AutoDisposeFutureProviderElement<List<StudentEntity>>
    with GetStudentsFromCSVRef {
  _GetStudentsFromCSVProviderElement(super.provider);

  @override
  List<StudentEntity> get studentList =>
      (origin as GetStudentsFromCSVProvider).studentList;
}

String _$studentListHash() => r'cedce3d747f82daeab3779ee73a6748166b6d965';

/// See also [StudentList].
@ProviderFor(StudentList)
final studentListProvider =
    AutoDisposeNotifierProvider<StudentList, List<StudentEntity>>.internal(
  StudentList.new,
  name: r'studentListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$studentListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StudentList = AutoDisposeNotifier<List<StudentEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member