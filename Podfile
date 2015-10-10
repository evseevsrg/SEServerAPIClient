# Uncomment this line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

xcodeproj 'SEServerAPIClient.xcodeproj'
def import_pods
    pod 'AFNetworking', '~> 2.5.3'
    pod 'Mantle', '~> 2.0'
    pod 'OCMock', '~> 3.1.3' 
    pod 'Typhoon'
end

target 'SEServerAPIClient' do
    import_pods
end

target 'SEServerAPIClientTests' do
    import_pods
    pod 'OCMock', '~> 3.1.3' 
end
