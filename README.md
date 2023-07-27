# PetChain

Welcome to your new PetChain project and to the internet computer development community. By default, creating a new project adds this README and some template files to your project directory. You can edit these template files to customize your project and to include your own code to speed up the development cycle.

## TypeScript (Azle) project: Pet's Clinic History on Internet Computer (ICP)
### Introduction
Pet Chain is a TypeScript (Azle) project developed on the Internet Computer (ICP) platform, designed to manage the medical history of domestic animals. This decentralized system aims to provide pet owners with exclusive access to their pets' clinical records, allowing them to view historical information, record relevant events related to their pet's daily life, schedule veterinary appointments, cancel appointments, and more. Additionally, the platform incorporates a special user type, dedicated to animal health professionals, who can contribute to the pet's clinical history by documenting their professional interactions with the animal, including medication prescriptions, treatments, diagnoses, medical tests, and appointment scheduling.

## Features and Functionality
### 1. Personalized Canisters for Each Pet
* Each pet's medical history is represented by a dedicated canister, ensuring the privacy and security of their data. The pet owner has exclusive access to the canister and can manage the clinical information and relevant day-to-day events of their furry companion.

### 2. Pet Owners' Capabilities
Pet owners can perform the following actions through the Pet Chain platform:

* View and access the complete medical history of their pet.
* Record day-to-day events related to their pet's life, such as behavioral observations or health incidents.
* Schedule appointments with veterinary clinics and manage their pet's appointments.
* Receive reminders for upcoming appointments and view a list of available time slots for scheduling.
### 3. Animal Health Professionals' Capabilities
* Animal health professionals, as specialized users, have the exclusive authority to add and manage medical data related to their professional interactions with the pet. Their privileges include:

* Prescribe medications and treatments for the pet based on their diagnosis.
* Document diagnoses and medical test results.
* Assign and update appointment schedules for the pet.
### 4. Appointment Management
*Pet Chain offers a streamlined appointment management system, where pet owners can choose from a list of available appointments provided by veterinary clinics. They can schedule, reschedule, or cancel appointments according to their preferences and the availability of the clinics.

## Benefits
### Pet Chain offers numerous advantages for both pet owners and animal health professionals:

* Centralized Medical History: The platform consolidates all medical information related to a pet in one accessible location, enhancing convenience and ensuring vital data is never lost.
* Effective Communication: Pet owners and animal health professionals can communicate effectively through the platform, fostering collaboration and better care for the pets.
* Data Privacy: Each pet's canister is isolated, providing secure and private access to the pet owner while also enabling controlled access to authorized professionals.
* Efficient Appointment Management: The appointment scheduling system optimizes the process for both pet owners and veterinary clinics, reducing scheduling conflicts and improving pet care.
## Conclusion
* Pet Chain, running on the decentralized Internet Computer (ICP), revolutionizes the way pet medical histories are managed. By providing pet owners and animal health professionals with secure access to comprehensive medical records, as well as allowing the recording of relevant day-to-day events, the platform aims to enhance the well-being and health of pets while streamlining veterinary care processes. With its user-friendly interface and collaborative features, Pet Chain promises to be an indispensable tool for every pet owner and animal health professional, ensuring that our beloved furry companions receive the best possible care.

To get started, you might want to explore the project directory structure and the default configuration file. Working with this project in your development environment will not affect any production deployment or identity tokens.

To learn more before you start working with PetChain, see the following documentation available online:

- [Quick Start](https://internetcomputer.org/docs/current/developer-docs/quickstart/hello10mins)
- [SDK Developer Tools](https://internetcomputer.org/docs/current/developer-docs/build/install-upgrade-remove)
- [Motoko Programming Language Guide](https://internetcomputer.org/docs/current/developer-docs/build/cdks/motoko-dfinity/motoko/)
- [Motoko Language Quick Reference](https://internetcomputer.org/docs/current/references/motoko-ref/)
- [JavaScript API Reference](https://erxue-5aaaa-aaaab-qaagq-cai.raw.icp0.io)

If you want to start working on your project right away, you might want to try the following commands:

```bash
cd PetChain/
dfx help
dfx canister --help
```

## Running the project locally

If you want to test your project locally, you can use the following commands:

```bash
# Starts the replica, running in the background
dfx start --background

# Deploys your canisters to the replica and generates your candid interface
dfx deploy
```

Once the job completes, your application will be available at `http://localhost:4943?canisterId={asset_canister_id}`.

If you have made changes to your backend canister, you can generate a new candid interface with

```bash
npm run generate
```

at any time. This is recommended before starting the frontend development server, and will be run automatically any time you run `dfx deploy`.

If you are making frontend changes, you can start a development server with

```bash
npm start
```

Which will start a server at `http://localhost:8080`, proxying API requests to the replica at port 4943.

### Note on frontend environment variables

If you are hosting frontend code somewhere without using DFX, you may need to make one of the following adjustments to ensure your project does not fetch the root key in production:

- set`DFX_NETWORK` to `ic` if you are using Webpack
- use your own preferred method to replace `process.env.DFX_NETWORK` in the autogenerated declarations
  - Setting `canisters -> {asset_canister_id} -> declarations -> env_override to a string` in `dfx.json` will replace `process.env.DFX_NETWORK` with the string in the autogenerated declarations
- Write your own `createActor` constructor
