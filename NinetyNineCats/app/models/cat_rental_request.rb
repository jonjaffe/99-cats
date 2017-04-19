class CatRentalRequest < ApplicationRecord
  validates :status, presence: true, inclusion: { in: %w(APPROVED DENIED PENDING) }
  validates :cat_id, :start_date, :end_date, presence: true
  validate :does_not_overlap_approved_request

  belongs_to :cat,
  primary_key: :id,
  foreign_key: :cat_id,
  class_name: :Cat

  def overlapping_requests
    puts start_date.class
    CatRentalRequest.where(cat_id: self.cat_id).where(<<-SQL, self.start_date, self.end_date, self.start_date, self.end_date)
    (? BETWEEN start_date AND end_date) OR (? BETWEEN start_date AND end_date) OR (? < start_date AND ? > end_date)
    SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  def approve!
    transaction do
      self.status = 'APPROVED'
      self.save
      self.overlapping_pending_requests.update_all(status: 'DENIED')
    end
  end

  def deny!
    self.status = 'DENIED'
  end

  private

  def does_not_overlap_approved_request
    errors[:base] << "Already booked!" if self.overlapping_approved_requests.exists?
  end
end
