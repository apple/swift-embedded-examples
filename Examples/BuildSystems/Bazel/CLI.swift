#if !hasFeature(Embedded)
#error("This code should only be compiled when the Embedded feature is enabled.")
#endif

@main
struct Application {
    static func main() {
        print("Hello from CLI.swift")
    }
}
