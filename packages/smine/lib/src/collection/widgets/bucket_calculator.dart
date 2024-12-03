class BucketCalculator {
  final double ratePerBucket;
  final int bucketQty;

  BucketCalculator({required this.ratePerBucket, required this.bucketQty}) {
    print(
        'BucketCalculator: Created with ratePerBucket: $ratePerBucket, bucketQty: $bucketQty');
  }

  double calculateBucketAmount(int selectedBuckets) {
    double amount = ratePerBucket * bucketQty * selectedBuckets;
    print(
        'BucketCalculator: Calculated amount for $selectedBuckets buckets: $amount');
    return amount;
  }
}
