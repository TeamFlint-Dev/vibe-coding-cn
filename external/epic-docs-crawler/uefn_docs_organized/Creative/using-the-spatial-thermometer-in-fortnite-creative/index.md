# Using the Spatial Thermometer Heatmap

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-the-spatial-thermometer-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:12:51.090400

---

The Spatial Thermometer is a method for displaying and managing memory across your island. The island is divided into cells (equal to a grid tile), and a heatmap can be displayed that shows how much memory each cell is using. Instead of just having an overall memory limit, you can adjust the amount of memory used cell by cell. This gives you greater flexibility when you are building complex islands that use a lot of memory.

## Spatial Thermometer

The Spatial Thermometer memory management system measures memory cell by cell, comparing the memory use of each one to the cells next to it. Instead of loading everything in the island and storing it, the island will only use memory to store what is seen and used. It unloads unseen props and terrain from memory. As players move around the island, the system only loads things the player can see and interact with.

## Prop and Device Memory

The **Spatial Thermometer** breaks an island down into a grid of cells. Each prop you place has a memory cost that affects the area around it, within a specific radius. When you place a prop, its memory cost is added to all the cells around it from which it can be seen.

When you add a **[device](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#device)** to the island, its memory cost is added to all cells in the island. Devices always need to be loaded in memory to operate and can't be swapped in and out like props. That's because devices affect players no matter where they are on the island, and you don't want them to stop working when players get too far away from them.

When you place a prop or device, the memory usage is shown by a colored circle around the item when you are previewing it before placing it. That colored circle shows how placing that prop or device will affect the memory in that area.

The Spatial Thermometer system gives you two methods to see how much memory you have used:

- The **Cell Memory Used** bar
- The **Heatmap**

### Cell Memory Used Bar

When you place a prop, the **Cell Memory Used** bar displays memory usage for the cell with the highest memory use within range of the spot where you place the prop. This shows the highest effect that placing the prop has on the memory use of nearby cells. If you don’t have a prop in hand, the Cell Memory Used Bar will show values for the cell with the highest memory cost on your island.

[![The Cell Memory Used bar](https://dev.epicgames.com/community/api/documentation/image/5a7d759b-927d-48ec-829e-de4c217b27b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a7d759b-927d-48ec-829e-de4c217b27b7?resizing_type=fit)

The Cell Memory Used bar

*Click image for full size.*

### Heatmap

The **Heatmap** shows you a color-coded representation of the cells on your island. On PC, open the Map screen by pressing M. The heatmap is displayed on the Map screen by default. While in the Map Screen, you can press T to toggle between three different modes:

- No Heatmap displayed
- Heatmap only
- Heatmap with cell memory amount displayed

|  |  |
| --- | --- |
| [Map Screen with Heatmap](https://dev.epicgames.com/community/api/documentation/image/42837f8c-c447-420b-a2b6-d33427cfc9b6?resizing_type=fit)  Map Screen with Heatmap | [Map Screen Heatmap with Cell Memory](https://dev.epicgames.com/community/api/documentation/image/21464725-47c5-4a4b-8cde-af919ad0364d?resizing_type=fit)  Map Screen Heatmap with Cell Memory |
| Map Screen with Heatmap | Map Screen Heatmap with Cell Memory |
| *Click image for full size.* | *Click image for full size.* |

If you have the heatmap displayed on the Map screen, it will also display on the minimap when you close the Map screen.

|  |  |  |
| --- | --- | --- |
| [Minimap with no heatmap](https://dev.epicgames.com/community/api/documentation/image/274b1dcf-65e9-42aa-b1df-fdbece746c58?resizing_type=fit)  Minimap with no heatmap | [Minimap with Heatmap Only](https://dev.epicgames.com/community/api/documentation/image/d98c7159-5112-4da6-b142-5b8e183d0496?resizing_type=fit)  Minimap with Heatmap Only | [Minimap Heatmap with Cell Memory Used](https://dev.epicgames.com/community/api/documentation/image/184278a9-7b17-4f73-8b0a-aca9ca713d03?resizing_type=fit)  Minimap Heatmap with Cell Memory Used |
| Minimap with No Heatmap | Minimap with Heatmap Only | Minimap Heatmap with Cell Memory Used |
| *Click image for full size.* | *Click image for full size.* | *Click image for full size.* |

You must be in Fly mode to toggle between the heatmap modes. This may change in future releases.

The colors on the heatmap give you an idea of the amount of memory that each cell is currently using.

- **Dark Blue**: 0% memory used
- **Light Blue**: 50% memory used
- **Yellow**: 75% memory used
- **Red**: 99% - 100% memory used. The cell is close to being over budget.

Tips for reducing memory in cells:

- **Remove props from the cell** itself to reduce its memory use.
- **Delete props from densely-packed cells nearby** to reduce the memory cost of the over-budget cell.
- **Delete some devices**, since those contribute memory use to every cell on the island.
