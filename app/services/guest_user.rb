class GuestUser

    def guest?
        true
    end

    def author?(_)
        false
    end

    def method_missing(name, *args, &block)
        return false if name.to_s.end_with?("_role?")
        super(name, *args, &block)
    end

    def respond_ro_missing?(anme, include_private)
        return true if name.to_s.end_with?("_ole?")
        super(name, include_private)
    end
end