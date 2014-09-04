require 'spec_helper'
require'factory_girl'

describe Gallery do
  let!(:gallery) { Gallery.create!(name: "Fartss") }
  it "creates a gallery" do
    expect(gallery.name).to eq("Fartss")
  end
 
  it "reads a gallery" do
    expect(Gallery.find_by(name: "Fartss")).to_not eq(nil)
  end

  it "updates a gallery" do 
    gallery.name = "Fart 1"
    gallery.save
    expect(gallery.name).to eq("Fart 1")
  end

  it "deletes a gallery" do 
    gallery.delete
    expect(Gallery.count).to eq(0)
  end

  it "paginates a gallery" do
    FactoryGirl.create_list(:attachment, 10)
    Attachment.update_all(gallery_id: gallery)
    expect(gallery.photos.page(1).count).to eq(5)
  end

  it "adds photos to a gallery" do 
    gallery = Gallery.create(name: "Fart Knocker", photos:  FactoryGirl.create_list(:attachment, 10))
    expect(gallery.photos.count).to eq(10)
  end

  it "retrieves the correct photos for a gallery" do
    gallery = Gallery.create(name: "Fart Knocker", photos: FactoryGirl.create_list(:attachment, 10))
    expect(gallery.photos.pluck(:gallery_id).find{|id| id == gallery.id}).to_not be_nil
  end

  it "moves photos from one gallery to another" do
    gallery1 = Gallery.create!(name: "Fart Knocker", photos:  FactoryGirl.build_list(:attachment, 10))
    gallery2 = Gallery.create!(name: "Fart Knocker 2", photos:  FactoryGirl.build_list(:attachment, 10))
    gallery1.move_images_to_gallery(gallery1.photos, gallery2)
    expect(gallery2.photos.pluck(:gallery_id).find{|id| id == gallery2.id}).to_not be_nil
  end
  
  it "deletes photos from a gallery" do
    Gallery.delete_all
    expect(Gallery.count).to eq(0)
  end

end
