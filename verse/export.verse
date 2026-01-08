#每个文件夹都是一个模块，但是这些模块的默认都是Privete
#需要使用同名声明的方式，将其声明为public才能正常访问
library<public> := module:
    dataComponents<public> := module:
    driverComponents<public> := module:
    logicModules<public> := module:
        coreMathUtils<public> := module:
        characterAndStateUtils<public> := module:
        economyAndTradeUtils<public> := module:
        inventoryAndItemsUtils<public> := module:
    sessions<public> := module:
templates<public> := module:
test<public> := module:
    test_support<public> := module:
    