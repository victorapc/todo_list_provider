import 'package:todo_list_provider/app/core/migration/migration.dart';
import 'package:todo_list_provider/app/core/migration/migration_v1.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [
        MigrationV1(),
      ];

  List<Migration> getUpgradeMigration(int version) => [];
}
