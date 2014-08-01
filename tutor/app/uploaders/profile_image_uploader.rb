class ProfileImageUploader < CarrierWave::Uploader::Base

	# Include RMagick support:
	include CarrierWave::RMagick

	# Choose what kind of storage to use for this uploader:
	storage :file
 
	# Add a default image as a fallback
	def default_url
		"/assets/profile.png"
	end

	# Override the directory where uploaded files will be stored.
	# This is a sensible default for uploaders that are meant to be mounted:
	def store_dir
		"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
	end

	# Process files as they are uploaded:
	process :resize_to_limit => [100, 100]

	# Create different versions of your uploaded files:
	version :profile do
		process :resize_to_fit => [100, 100]
	end

	# Add a white list of extensions which are allowed to be uploaded.
	# For images you might use something like this:
	def extension_white_list
		%w(jpg jpeg gif png)
	end

end