import SwiftUI

struct MyListsView: View {

    let myLists: FetchedResults<MyList>

    var body: some View {
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                Text("A lista de lembretes está vazia")
            } else {
                ForEach(myLists) { myList in
                    VStack {
                        MyListCellView(myList: myList)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading], 10)
                            .font(.title3)
                        Divider()
                    }
                }
            }
        }
    }
}
