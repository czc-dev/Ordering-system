# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(employee)
    alias_action :create, :read, :update, :destroy, to: :crud

    can :read, Employee, organization: { id: employee.organization_id }
    can :crud, Patient,  organization: { id: employee.organization_id }
    can :crud, Order,    patient: { organization: { id: employee.organization_id } }
    can :crud, Exam,     order: { patient: { organization: { id: employee.organization_id } } }
    can :read, Invitation, organization: { id: employee.organization_id }
    can :read, ExamItem, organization: { id: employee.organization_id }
    can :read, ExamSet,  organization: { id: employee.organization_id }
  end
end
