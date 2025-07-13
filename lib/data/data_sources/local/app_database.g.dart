// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `products` (`images` TEXT, `thumbnail` TEXT NOT NULL, `rating` REAL, `returnPolicy` TEXT, `description` TEXT, `weight` INTEGER, `title` TEXT NOT NULL, `tags` TEXT, `discountPercentage` REAL, `price` REAL, `id` INTEGER, `availabilityStatus` TEXT, `category` TEXT, `stock` INTEGER, `sku` TEXT, `brand` TEXT, `images` TEXT, `thumbnail` TEXT, `rating` REAL, `returnPolicy` TEXT, `description` TEXT, `weight` INTEGER, `title` TEXT, `tags` TEXT, `discountPercentage` REAL, `price` REAL, `id` INTEGER, `availabilityStatus` TEXT, `category` TEXT, `stock` INTEGER, `sku` TEXT, `brand` TEXT, PRIMARY KEY (`id`, `id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productModelInsertionAdapter = InsertionAdapter(
            database,
            'products',
            (ProductModel item) => <String, Object?>{
                  'images': _listStringConverter.encode(item.images),
                  'thumbnail': item.thumbnail,
                  'rating': item.rating,
                  'returnPolicy': item.returnPolicy,
                  'description': item.description,
                  'weight': item.weight,
                  'title': item.title,
                  'tags': _listStringConverter.encode(item.tags),
                  'discountPercentage': item.discountPercentage,
                  'price': item.price,
                  'id': item.id,
                  'availabilityStatus': item.availabilityStatus,
                  'category': item.category,
                  'stock': item.stock,
                  'sku': item.sku,
                  'brand': item.brand,
                  'images': _listStringConverter.encode(item.images),
                  'thumbnail': item.thumbnail,
                  'rating': item.rating,
                  'returnPolicy': item.returnPolicy,
                  'description': item.description,
                  'weight': item.weight,
                  'title': item.title,
                  'tags': _listStringConverter.encode(item.tags),
                  'discountPercentage': item.discountPercentage,
                  'price': item.price,
                  'id': item.id,
                  'availabilityStatus': item.availabilityStatus,
                  'category': item.category,
                  'stock': item.stock,
                  'sku': item.sku,
                  'brand': item.brand
                }),
        _productModelDeletionAdapter = DeletionAdapter(
            database,
            'products',
            ['id', 'id'],
            (ProductModel item) => <String, Object?>{
                  'images': _listStringConverter.encode(item.images),
                  'thumbnail': item.thumbnail,
                  'rating': item.rating,
                  'returnPolicy': item.returnPolicy,
                  'description': item.description,
                  'weight': item.weight,
                  'title': item.title,
                  'tags': _listStringConverter.encode(item.tags),
                  'discountPercentage': item.discountPercentage,
                  'price': item.price,
                  'id': item.id,
                  'availabilityStatus': item.availabilityStatus,
                  'category': item.category,
                  'stock': item.stock,
                  'sku': item.sku,
                  'brand': item.brand,
                  'images': _listStringConverter.encode(item.images),
                  'thumbnail': item.thumbnail,
                  'rating': item.rating,
                  'returnPolicy': item.returnPolicy,
                  'description': item.description,
                  'weight': item.weight,
                  'title': item.title,
                  'tags': _listStringConverter.encode(item.tags),
                  'discountPercentage': item.discountPercentage,
                  'price': item.price,
                  'id': item.id,
                  'availabilityStatus': item.availabilityStatus,
                  'category': item.category,
                  'stock': item.stock,
                  'sku': item.sku,
                  'brand': item.brand
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductModel> _productModelInsertionAdapter;

  final DeletionAdapter<ProductModel> _productModelDeletionAdapter;

  @override
  Future<List<ProductModel>> getFavorites() async {
    return _queryAdapter.queryList('SELECT * FROM products',
        mapper: (Map<String, Object?> row) => ProductModel(
            images: _listStringConverter.decode(row['images'] as String?),
            thumbnail: row['thumbnail'] as String,
            rating: row['rating'] as double?,
            returnPolicy: row['returnPolicy'] as String?,
            description: row['description'] as String?,
            weight: row['weight'] as int?,
            title: row['title'] as String,
            tags: _listStringConverter.decode(row['tags'] as String?),
            discountPercentage: row['discountPercentage'] as double?,
            price: row['price'] as double?,
            id: row['id'] as int?,
            availabilityStatus: row['availabilityStatus'] as String?,
            category: row['category'] as String?,
            stock: row['stock'] as int?,
            sku: row['sku'] as String?,
            brand: row['brand'] as String?));
  }

  @override
  Future<void> addToFavorites(ProductModel product) async {
    await _productModelInsertionAdapter.insert(
        product, OnConflictStrategy.abort);
  }

  @override
  Future<void> removeFromFavorites(ProductModel product) async {
    await _productModelDeletionAdapter.delete(product);
  }
}

// ignore_for_file: unused_element
final _listStringConverter = ListStringConverter();
