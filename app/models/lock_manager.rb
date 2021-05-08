require 'digest'

# Manages pessimistic offline lock.
# This enables business transaction over requests.
class LockManager
  class LockManagerError < StandardError; end

  def lock(lockable, session_id)
    raise LockManagerError, "locked" if locked_by_others?(lockable, session_id)

    Lock.find_or_create_by!(uid: lockable_id(lockable), session_id: session_id)
  end

  def release(lockable, session_id)
    Lock.find_by(uid: lockable_id(lockable), session_id: session_id).destroy!
  end

  def locked_by_others?(lockable, session_id)
    Lock.where.not(session_id: session_id).find_by(uid: lockable_id(lockable))
  end

  private

  def lockable_id(lockable)
    Digest::SHA1.hexdigest(lockable.class.name + lockable.id.to_s)
  end

  def has_lock?(lockable, session_id)
    Lock.find_by(uid: lockable_id(lockable), session_id: session_id)
  end
end
