import SwiftUI

struct ContentView: View {
    @State private var title: String = ""
    
    @State private var runtimeHoursText: String = ""
    @State private var runtimeMinutesText: String = ""
    
    @State private var castPopularity: Double = 5
    @State private var releaseMonthIndex: Int = 0
    @State private var selectedGenreIndex: Int = 0
    
    @State private var predictedProfit: String = ""
    
    private let genres = ["Action", "Comedy", "Drama", "Horror", "Animation"]
    private let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                          "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Movie Info")) {
                    TextField("Movie Title", text: $title)
                    
                    Picker("Genre", selection: $selectedGenreIndex) {
                        ForEach(0..<genres.count, id: \.self) {
                            Text(genres[$0])
                        }
                    }
                    
                    Picker("Release Month", selection: $releaseMonthIndex) {
                        ForEach(0..<months.count, id: \.self) {
                            Text(months[$0])
                        }
                    }
                }
                
                Section(header: Text("Runtime")) {
                    HStack {
                        TextField("Hours", text: $runtimeHoursText)
                            .keyboardType(.numberPad)
                            .frame(width: 70)
                        
                        Text("hr")
                        
                        TextField("Minutes", text: $runtimeMinutesText)
                            .keyboardType(.numberPad)
                            .frame(width: 80)
                        
                        Text("min")
                    }
                }
                
                Section(header: Text("Cast Popularity")) {
                    VStack(alignment: .leading) {
                        Text("Cast Popularity: \(Int(castPopularity))/10")
                        Slider(value: $castPopularity, in: 1...10, step: 1)
                    }
                }
                
                Section {
                    Button("Predict Profit", action: calculatePrediction)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section(header: Text("Predicted Profit")) {
                    if predictedProfit.isEmpty {
                        Text("Fill out the form and tap Predict.")
                            .foregroundColor(.secondary)
                    } else {
                        Text(predictedProfit)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
            }
            .navigationTitle("AI Movie Predictor")
        }
    }
    
    private func calculatePrediction() {
        let hours = Double(runtimeHoursText) ?? 0
        let minutes = Double(runtimeMinutesText) ?? 0
        let runtime = hours * 60 + minutes
        
        // Genre multiplier
        let genreBoost: Double = {
            switch genres[selectedGenreIndex] {
            case "Action": return 1.4
            case "Comedy": return 1.2
            case "Drama": return 1.1
            case "Horror": return 1.0
            case "Animation": return 1.3
            default: return 1.0
            }
        }()
        
        // Release month boost (summer + holidays)
        let monthBoost: Double = {
            switch months[releaseMonthIndex] {
            case "May", "Jun", "Jul": return 1.5
            case "Nov", "Dec": return 1.3
            default: return 1.0
            }
        }()
        
        // Cast popularity boost
        let castBoost = 0.8 + (castPopularity / 10) * 0.7
        
        // Runtime bonus
        let runtimeBonus = max(0, (runtime - 90) * 0.05)
        
        // Profit computation
        let base: Double = 50
        let profit = base * genreBoost * monthBoost * castBoost + runtimeBonus
        
        predictedProfit = String(format: "$%.1f million (approx.)", profit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

