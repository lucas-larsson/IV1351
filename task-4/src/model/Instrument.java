package model;

/**
 * Author: DENNIS HADZIALIC
 * Date: 2022-01-06
 * Description:
 **/
public class Instrument {
    private String instrumentId;
    private String instrument;
    private String brand;
    private double price;
    private boolean isRented;

    public Instrument(String instrumentId, String instrument, String brand, double price, boolean isRented) {
        this.instrumentId = instrumentId;
        this.instrument = instrument;
        this.brand = brand;
        this.price = price;
        this.isRented = isRented;
    }

    @Override
    public String toString() {
        return "{" +
                "instrument='" + instrument + '\'' +
                ", brand='" + brand + '\'' +
                ", price=" + price +
                " SEK}";
    }
}
