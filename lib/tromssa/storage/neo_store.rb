module Tromssa
  module Storage
    class NeoStore
      def registration
        Tromssa::Storage::Neo::Registration.new
      end

      def club
        Tromssa::Storage::Neo::Club.new
      end
    end
  end
end

