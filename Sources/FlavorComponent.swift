import Swinject


/**
 The FlavorComponent class provides a means to load a different component assembly based on a given flavor. This is
 useful for swapping in/out a mock assembly. For example, you might have a service layer that has a mock implementation
 where you have `ServiceAssembly` and `MockServiceAssembly` implementations. If you create a Mock flavor you can easily
 swap these implementations in the container with little effort:
 
 ```
 FlavorComponent<ServiceAssembly, MockServiceAssembly>(flavor: .Mock)
 ```
 */
final public class FlavorComponent<Assembly, FlavorAssembly where Assembly: Constructible, Assembly: AssemblyType,
FlavorAssembly: Constructible, FlavorAssembly: AssemblyType> {
    
    /// the flavor for this component that will use to swap on
    private let flavor: Flavor
    
    /**
     Will create a FlavorComponent that will use the flavor assembly if the the flavor is requested otherwise
     it will use the normal Assembly
     
     - parameter flavor: the flavor to use for the FlavorAssembly
     */
    public init(flavor: Flavor) {
        self.flavor = flavor
    }
}

// MARK: - ComponentType
extension FlavorComponent: ComponentType {
    public func assemblyForFlavor(flavor: Flavor?) -> AssemblyType {
        if let f = flavor where self.flavor == f {
            return FlavorAssembly()
        }
        return Assembly()
    }
}