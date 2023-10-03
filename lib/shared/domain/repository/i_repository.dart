abstract class IRepository<T> {
  Future<List<T>> getAll();
  Future<T?> get(int id);
  Future<void> post(T input);
  Future<void> put(T input);
  Future<void> delete(int id);
}
