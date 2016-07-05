require 'rails_helper'

describe Photo do
  let(:payload) {
    {
      id: 70,
      name: 'Crazy Lobster',
      description: 'Dr. Zoidberg',
      camera: 'NIKON D610',
      lens: "35.0 mm f/1.4",
      rating: 99.7,
      created_at: '2016-07-05T06:12:47-04:00',
      image_url: 'https://url.for/image',
      images: [
        {
          size: 3,
          url: 'https://url.for/photo',
          https_url: 'https://url.for/photo',
          format: 'jpeg'
        }
    ],
    user: {
      id: 141796,
      username: 'deliveryboi',
      firstname: 'Philip',
      lastname: 'Fry',
      city: 'New New York',
      country: 'USA',
      usertype: 0,
      fullname: 'Philip J. Fry',
      userpic_url: 'https://url.for/user_pic' 
    }
    }
  }

  let(:photo) { Photo.new(payload) }

  it "should only access the required data" do
    expect(photo.name).to eq('Crazy Lobster')
    expect(photo.image_url).to eq('https://url.for/image')
    expect { photo.images }.to raise_error(NoMethodError)
  end

  it "should parse the user" do
    user = photo.user

    expect(user.fullname).to eq('Philip J. Fry')
    expect { user.userpic_url }.to raise_error(NoMethodError)
  end
end
