class Ability
    include CanCan::Ability

    def initialize(user)
        if user.has_role?(:super)
            superuser_abilities(user)
        elsif user.has_role?(:admin)
            admin_abilities(user)
        elsif user.has_role?(:staff)
            staff_abilities(user)
        end
    end

    def superuser_abilities(user)
        can :manage, :all
    end

    def admin_abilities(user)
        can [:create, :read], Client
        can [:create, :read], Invoice
        can [:create, :read], InvoiceItem
        can [:create, :read], Material
        can [:create, :read], Payment
        can [:read], PaymentType
        can [:create, :read], PettyCash
        can [:create, :read], PettyCashItem
        can [:create, :read, :update], Site
    end

    def staff_abilities(user)
        can [:create, :read, :update], NextOfKin
        can [:create, :read, :update], Painter
        can [:create, :read, :update], PainterContact
        can [:create, :read, :update], PainterSkill
        can [:create, :read], PettyCash
        can [:create, :read], PettyCashItem
        can [:create, :read, :update], Skill
        can [:create, :read], Material
        can :read, TrackPainter 
        can :read, TrackPainterItem
        can [:create, :read, :update], Material
        can [:create, :read, :update], Payment
        can [:create, :read, :update], Deduction
        can [:create, :read, :update], Holiday
        can [:create, :read, :update], Invoice
        can [:create, :read, :update], InvoiceItem
        can [:create, :read, :update], Paint
    end


end
# bonu
# client
# deduction
# deduction_installment
# employment_type
# holiday
# invoice
# invoice_item
# material
# next_of_kin
# paint
# painter
# painter_contact
# painter_skill
# payment
# payment_type
# petty_cash
# petty_cash_item
# site
# site_agreed_amount
# site_rate
# site_square_metres
# skill 
# track_painter
# track_painter_item
# user
# user_type
