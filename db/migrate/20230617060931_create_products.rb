class CreateProducts < ActiveRecord::Migration[7.0]
  def change

    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.decimal :size
      t.boolean :is_spicy
      t.boolean :is_veg
      t.boolean :is_best_offer
      t.string :path_to_image

      t.timestamps
    end

    Product.create :title => 'Hawaiian',
      :description => 'Это гавайская пицца',
      :price => 350,
      :size => 30,
      :is_spicy => false,
      :is_veg => false,
      :is_best_offer => false,
      :path_to_image => '/images/Hawaiian.jpg'

    Product.create :title => 'Peperroni',
      :description => 'Это пицца Пепперони',
      :price => 450,
      :size => 30,
      :is_spicy => false,
      :is_veg => false,
      :is_best_offer => true,
      :path_to_image => '/images/Peperroni.jpg'

    Product.create :title => 'Vegetarian',
      :description => 'Это вегетарианская пицца',
      :price => 400,
      :size => 30,
      :is_spicy => false,
      :is_veg => true,
      :is_best_offer => false,
      :path_to_image => '/images/Vegetarian.jpg'
  end
end
