# Talisman MetaHuman Template

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/talisman-metahuman-template-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:05:58.674610

---

The **Talisman: MetaHuman** template showcases Unreal Editor for Fortnite's (UEFN) out-of-this-world technology, where creators can import and use [**MetaHumans**](metahuman-overview-in-unreal-editor-for-fortnite), our high-fidelity digital humans.

You can find the Talisman: MetaHuman template in the **Feature Examples** section of the **Project Browser**.

You can play the Talisman experience shown during the 2024 Game Developers Conference by opening Fortnite and entering island code **7100-3544-3074**.

[![Captain standing on bridge](https://dev.epicgames.com/community/api/documentation/image/86726c4d-217c-4ada-888d-0bcc11501985?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/86726c4d-217c-4ada-888d-0bcc11501985?resizing_type=fit)

To create your own MetaHumans, open the [MetaHuman Creator](https://metahuman.unrealengine.com/), and then import them into your project.

## Project Challenges

Bringing MetaHumans from Unreal Engine to UEFN presented the following challenges:

- **Memory limits**: UEFN has a maximum limit of 2 GB of disk space for the project upload size, and a 400 MB limit for the download size. This was a challenge as the average MetaHuman in Unreal Engine required 800 MB of disk space.
- **Performance:** UEFN needs to run at different FPS settings depending on the target platform. This presents a challenge when importing several MetaHumans into a project, as the MetaHumans were heavy on performance.
- **Quality on all target platforms:** The team needed to ensure that MetaHumans kept a high-fidelity, consistent appearance on all target platforms. In addition, the team needed to maintain compatibility with existing Unreal Engine MetaHuman meshes and rigs.

## MetaHuman Optimization

The MetaHuman team worked on a variety of optimizations to address the challenges mentioned above.

As a result, MetaHumans in UEFN now require an average of 60 MB of disk space, down from 800 MB, while keeping a high-fidelity presentation on all target platforms.

### Texture and Material Optimizations

[![UE and UEFN comparison](https://dev.epicgames.com/community/api/documentation/image/729fb687-f99c-4fd9-b0cb-23007600390f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/729fb687-f99c-4fd9-b0cb-23007600390f?resizing_type=fit)

Textures were compressed, which resulted in a 50% reduction in the overall memory footprint. Materials were optimized to have less instructions. We also baked multiple textures into the materials, resulting in further memory savings.

### Level of Detail (LOD) Adjustments

[![Ada UEFN LODs](https://dev.epicgames.com/community/api/documentation/image/c461f507-2633-495b-be47-d1f4e9042b2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c461f507-2633-495b-be47-d1f4e9042b2e?resizing_type=fit)

The team adjusted all available LODs per platform, to ensure optimized performance by default. The body and face both come with 4 LODs.

The LODSync component manages the seamless transition of LODs between all MetaHuman components.

To learn more about optimizing MetaHumans in UEFN, see [Setting Up MetaHumans in UEFN](https://dev.epicgames.com/documentation/metahuman/downloading-and-exporting-metahumans/setting-up-metahumans-in-uefn).

### Animation Optimization

The team optimized the animations for the face and body, resulting in a significant performance improvement over its original fully-enabled presentation.

The animation Blueprint (state machine) and Control Rig rely on the MetaHuman Component to enable and disable options, such as neck correctives, procedural adjustments with Control Rig, and even facial animations. To learn more about animation, see the [Animating MetaHumans](https://dev.epicgames.com/documentation/metahuman/animating-metahumans) section.

### Hair Optimization

[![hair on a MetaHuman](https://dev.epicgames.com/community/api/documentation/image/35f6b153-6874-4353-973b-7502f418c860?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/35f6b153-6874-4353-973b-7502f418c860?resizing_type=fit)

MetaHumans use [Grooms](https://dev.epicgames.com/documentation/en-us/unreal-engine/hair-rendering-and-simulation-in-unreal-engine) to produce strand-based hair at **LOD 0**, and traditional hair cards for lower LODs.

The groom assets were optimized to reduce their cook size by about 50% and improve their performance.

## Cloth Simulation in UEFN

The Talisman template showcases Unreal Engine's (UE) [Chaos Cloth](https://dev.epicgames.com/documentation/en-us/fortnite/creating-clothing-assets-for-unreal-editor-for-fortnite-using-unreal-engine) technology, which provides MetaHumans with accurate and performant cloth simulation.

Your own projects can feature MetaHumans with customized cloth like the one used in this template.

[![clothing pipeline](https://dev.epicgames.com/community/api/documentation/image/0c2c067d-08dd-4f4b-9ca2-73fc341128fe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c2c067d-08dd-4f4b-9ca2-73fc341128fe?resizing_type=fit)

You can author your **clothing meshes** from any **Digital Content Creation (DCC) package**, and import them to **Unreal Engine** to convert them to **clothing assets**. You can then export these assets to UEFN, and use them in-game with the Chaos Cloth component.

You can experience the Chaos Cloth technology in action once you launch this template in Fortnite Creative. The cloth simulation on the captain is disabled by default, to improve performance on all platforms, and only runs while playing the [cinematic sequence](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#cinematic-sequence).

## Activating the Metahuman Cinematic

[![Captain cinematic sequence](https://dev.epicgames.com/community/api/documentation/image/599dd7a9-da39-4ad5-af2e-1bc7b23d0b33?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/599dd7a9-da39-4ad5-af2e-1bc7b23d0b33?resizing_type=fit)

To activate the cinematic sequence and see the cloth simulation, launch the project, and press the button next to the MetaHuman.

This cutscene is played through a [Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite) device, which you can modify through its device settings. During this cutscene, you can interact with the MetaHuman for a short dialogue.

## Downloadable Learning Assets

As part of the Talisman: MetaHuman template learning efforts, several assets were made for you to use within the templates and learn more about MetaHumans and clothing simulation in UEFN.

This includes Captain Roux, the captain from the Talisman demo, their jacket made in Marvelous Designer, adjusted textures in a Photoshop file, and an Unreal Engine project where you can see Captain Roux with a small jacket animation.

A second set of assets was also added for the new Captain Elli. They include a MetaHuman file, a [sweater made in Marvelous Designer](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-sweater-with-marvelous-designer-in-unreal-editor-for-fortnite), and an Unreal Engine project showing Captain Elli with a small animation while wearing the sweater.

Download the assets to closely examine and play with the MetaHumans and clothing and see how you can bring them into UEFN.

To access the file, open **Verse Explorer** from the main menu. When the explorer window pops up, you will see the file `camera_switch_mode_device.verse`. Open the file and the link is [commented](https://dev.epicgames.com/documentation/en-us/fortnite/comments-in-verse) in the code at the top of the file. For more information on how to access Verse Explorer see the [Verse Explorer User Interface Reference Guide](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite).

[![camera verse file in explorer](https://dev.epicgames.com/community/api/documentation/image/74bfdc98-803d-4d52-87f5-a867d133d831?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/74bfdc98-803d-4d52-87f5-a867d133d831?resizing_type=fit)

The usage of these assets is subject to the UEFN Supplemental Terms, which you agreed to when first downloading UEFN.

## Related Topics

Interested in seeing more of the Talisman ship?

Explore additional learning materials for the Talisman project and UEFN MetaHuman workflows from the [Realistic Assets, Characters, and Environments](realistic-assets-characters-environments-in-unreal-editor-for-fortnite) landing page.

[![Talisman environment template](https://dev.epicgames.com/community/api/documentation/image/4f35a9d1-6bb3-4e46-96fd-bd63a7e19ded?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f35a9d1-6bb3-4e46-96fd-bd63a7e19ded?resizing_type=fit)
