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
                    NavigationLink(value: myList) {
                        VStack {
                            MyListCellView(myList: myList)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading], 10)
                                .font(.title3)
                            Divider()
                        }
                    }
                }.scrollContentBackground(.hidden)
                    .navigationDestination(for: MyList.self) { myList in
                        MyListDetailView(myList: myList).navigationTitle(myList.name)
                    }
            }
        }
    }
}
