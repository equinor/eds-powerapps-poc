# EDS Power Apps POC

This repository is for evaluating how to support Power Apps in the [Equinor Design System](https://eds.equinor.com). The content will be moved to the [EDS repo](https://github.com/equinor/design-system) once we know what we’re doing 😉 We’re currently using Github actions to export and import into different environments, but we also keep an eye on the [ALM Accelerator](https://github.com/microsoft/coe-starter-kit) in the CoE Start Kit, so we may switch to that at some point once they have the Github version up and and running.

The first MVP will be a modification of [Bulb Digitals template](https://www.bulb.digital/blog/simplify-your-powerapps-branding-with-a-theme-template), which again is inspired by the work of [IAmManCat (Sancho Harker)](https://github.com/iAmManCat).

## Tooling

Since the [PowerPlatform Github actions](https://github.com/microsoft/powerplatform-actions) don’t actually unpack the `.msapp` file we have [an action](https://github.com/equinor/eds-powerapps-poc/blob/main/.github/workflows/build-pasopa.yaml) that clones the [PowerApps-Language-Tooling](https://github.com/microsoft/PowerApps-Language-Tooling) repo and builds a standalone app and commits that directly to this repository in the tools folder so it can be used as [a step in the other import/export actions](https://github.com/equinor/eds-powerapps-poc/blob/main/.github/workflows/export.yaml#L51-L56) – but we use pull requests for everything else. 

PASopa can also be run locally, and has mac support since [version 0.2.1-preview](https://github.com/microsoft/PowerApps-Language-Tooling/releases). So in order to build a version that runs on Big Sur, you would have to download the [.NET Core SDK](https://dotnet.microsoft.com/download/dotnet/3.1) and run `dotnet publish -r osx.11.0-x64 -p:PublishSingleFile=true --self-contained true` from the src folder. That would give you a standalone app in `./bin/Debug/PASopa/netcoreapp3.1/osx.11.0-x64/publish/PASopa` that you can then move into `~/.local/bin` and run `PASopa -unpack SomeApp.msapp` for example in the terminal assuming you have `~/.local/bin` in your path. 

So then all we need is a mac version of [Power Apps CLI](https://docs.microsoft.com/en-us/powerapps/developer/data-platform/powerapps-cli) 😎

## License

We use an MIT license in the EDS. The Bulb Digital template does not have a license, but we’ve clarified with Michael Wright in Bulb Digital that we can modifiy their template under an MIT license.

![image](https://user-images.githubusercontent.com/2081882/116526023-71782180-a8d9-11eb-9f39-51b5f9546034.png)
