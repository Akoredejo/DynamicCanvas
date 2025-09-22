# 🎨 DynamicCanvas

* * * * *

ℹ️ **Project Overview**
-----------------------

`DynamicCanvas` is a comprehensive smart contract suite for the creation, customization, and trading of generative art NFTs on the Stacks blockchain. It provides a robust, on-chain framework that goes beyond simple NFT minting to enable a dynamic and evolving artistic ecosystem. Users can mint a base NFT, then apply a wide range of artistic **traits** (e.g., filters, textures, and styles) to permanently and provably modify their artwork. The contract incorporates features for tracking trait application, calculating rarity scores based on applied traits, and a novel **collaborative customization engine** that allows multiple users to contribute to the evolution of a single piece of art, rewarding collaboration and artistic innovation.

This project is designed for artists and collectors who seek a more interactive and community-driven approach to digital art ownership. `DynamicCanvas` ensures that each NFT is not a static image but a living piece of art that can change and grow over time, with every modification transparently recorded on the blockchain.

* * * * *

🛠️ **Core Features**
---------------------

### **1\. Base NFT Minting**

Users can mint a foundational generative art NFT from a predefined template. This serves as the starting point for all subsequent customizations.

### **2\. Dynamic Trait Customization**

Owners can apply various artistic traits to their NFTs. Each trait is defined with its own properties, including rarity and cost, which directly impact the NFT's final **rarity score**. This process permanently alters the NFT's on-chain metadata, creating a unique and evolving digital asset.

### **3\. Rarity Scoring System**

The contract implements a sophisticated rarity scoring algorithm that dynamically adjusts an NFT's score based on the rarity of its applied traits and the total number of traits. This provides a quantifiable measure of an NFT's uniqueness and value.

### **4\. Collaborative Customization Engine**

A groundbreaking feature that enables a **multi-stage, multi-participant customization process**. This engine allows for the application of complex trait combinations, community voting, and dynamic pricing based on market demand and community consensus. It also includes an automated reward distribution system for participants who successfully contribute to a collaborative artwork's evolution.

### **5\. Provable Ownership and History**

All minting and customization actions are recorded on the Stacks blockchain, providing a **provable, immutable history** of each NFT's evolution. This ensures transparency and verifies the authenticity of every modification.

### **6\. Statistical Tracking**

The contract tracks various user and contract-level statistics, such as the number of NFTs owned, customizations applied, and collaboration earnings, providing valuable data and potential for future gamification or reward mechanisms.

* * * * *

⚙️ **Smart Contract Functions**
-------------------------------

### **Public Functions**

-   `mint-base-nft (template: (string-ascii 50))`: Mints a new base NFT with a specified template.

-   `create-trait-definition (trait-type: (string-ascii 30), rarity: uint, cost: uint)`: Allows a user to define a new artistic trait with its rarity and cost.

-   `apply-customization (token-id: uint, trait-type: (string-ascii 30), trait-value: (string-ascii 50))`: Applies a single trait to an NFT, updating its rarity score and history.

-   `execute-collaborative-customization-engine (...)`: Executes an advanced, multi-stage, collaborative customization process with dynamic pricing and reward distribution.

### **Private Functions**

-   `calculate-rarity-score (token-id: uint)`: Internal function to compute an NFT's rarity score based on its traits.

-   `get-trait-rarity (trait-index: uint)`: Fetches the rarity of a specific trait.

-   `generate-trait-indices (...)`: A simplified function for iterating through traits.

-   `update-user-stats (...)`: Manages and updates user-specific statistics.

* * * * *

💾 **Data Structures**
----------------------

### **Data Variables**

-   `next-token-id`: A counter for the next available NFT token ID.

-   `total-customizations`: Tracks the total number of customizations performed across all NFTs.

-   `contract-balance`: The total STX held by the contract from fees.

### **Data Maps**

-   `nft-data`: Stores the core metadata for each NFT, including owner, trait count, rarity score, and modification history.

-   `nft-traits`: A detailed record of each trait applied to an NFT, including its type, value, rarity tier, and who applied it.

-   `trait-definitions`: Contains the global definitions for all available traits, including their base rarity, cost, and usage statistics.

-   `user-stats`: Tracks key statistics for each user, such as NFTs owned and customizations applied.

* * * * *

⚠️ **Error Codes**
------------------

-   `u100`: `ERR-UNAUTHORIZED`: The sender does not have permission to perform this action.

-   `u101`: `ERR-NOT-FOUND`: The specified NFT or trait was not found.

-   `u102`: `ERR-ALREADY-EXISTS`: The item you are trying to create already exists.

-   `u103`: `ERR-INSUFFICIENT-PAYMENT`: The sender's balance is insufficient to cover the cost.

-   `u104`: `ERR-INVALID-TRAIT`: The specified trait is invalid or does not meet criteria.

-   `u105`: `ERR-CUSTOMIZATION-LOCKED`: The NFT is currently locked from further customization.

-   `u106`: `ERR-MAX-TRAITS-EXCEEDED`: The maximum number of traits for this NFT has been reached.

* * * * *

⚖️ **License**
--------------

```
MIT License

Copyright (c) 2025 DynamicCanvas

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

```

* * * * *

🤝 **Contribution**
-------------------

We welcome contributions from the community to improve `DynamicCanvas`. If you're an artist, developer, or enthusiast, you can help by:

-   **Reporting Bugs**: File an issue on our GitHub repository if you find a bug.

-   **Proposing Features**: Suggest new features or improvements to the contract.

-   **Writing Documentation**: Help us create better documentation for the contract and its features.

-   **Creating Traits**: Propose new trait definitions and artistic concepts that can be integrated into the system.

Please ensure all contributions align with the project's goals of fostering a collaborative and innovative on-chain art ecosystem.

* * * * *

🚀 **Future Roadmap**
---------------------

-   **Decentralized Trait Marketplace**: Implementing a marketplace for artists to create, sell, and trade their own custom trait definitions.

-   **DAO-governed Features**: Transitioning core contract parameters (e.g., fees, multipliers) to be governed by a DAO, allowing the community to vote on future changes.

-   **Royalty Distribution Engine**: An advanced system for distributing royalties to both the original NFT creator and the creators of applied traits.

-   **Interoperability with Other Protocols**: Exploring integrations with other Stacks and Bitcoin-based protocols to enhance the utility and reach of `DynamicCanvas` NFTs.

* * * * *

📞 **Contact & Support**
------------------------

For questions, support, or collaboration inquiries, please reach out to us through our official channels.
