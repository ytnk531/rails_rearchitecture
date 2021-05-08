# Unit of work for database transactions.
# This class handles synchronization of object and data source.
# Register objects and call commit to synchronize at the last.
# This method allows you to postpone executing queries.
class UnitOfWork
  def initialize
    @new = []
    @dirty = []
    @deleted = []
  end

  def register_new(object)
    @new << object
  end

  def register_dirty(object)
    @dirty << object
  end

  def register_deleted(object)
    @deleted << object
  end

  def commit
    ActiveRecord::Base.transaction do
      insert_new
      update_dirty
      delete_removed
    end
  end

  private

  def insert_new
    @new.each { _1.save! }
  end

  def update_dirty
    @dirty.each { _1.save! }
  end

  def delete_removed
    @deleted.each { _1.destroy! }
  end
end
