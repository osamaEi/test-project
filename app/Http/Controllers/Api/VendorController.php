<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

use App\Models\Category;
use App\Models\Vendor; 
use App\Http\Controllers\Controller; 
use App\Http\Resources\VendorResource;
use App\Http\Resources\CategoryResource;
use App\Http\Resources\ShowVendorResource;
use App\Repositories\Contracts\VendorRepositoryInterface;
use App\Repositories\Contracts\CategoryRepositoryInterface;

class VendorController extends Controller
{ 
    protected $vendorRepository;
    protected $categoryRepository;
 
    public function __construct(
        VendorRepositoryInterface $vendorRepository,
        CategoryRepositoryInterface $categoryRepository
    
    )
    {
        $this->vendorRepository = $vendorRepository;
        $this->categoryRepository = $categoryRepository;
    
    }
    // Display a listing of vendors
    public function index()
    {
        $vendors = $this->vendorRepository->getAllActiveAndApproved();

         return response()->json([
            'status' => true,
            'message' => 'data fetched',
            'data' => VendorResource::collection($vendors)
        
        ]);
    }

    public function findByCategory($id){

        $vendors = $this->vendorRepository->findByCategory($id);
        
           return response()->json([
            'status' => true,
            'message' => 'data fetched',
            'data' => VendorResource::collection($vendors)
        
        ]);


    }


    public function show($id){

        $vendor = $this->vendorRepository->find($id);

         
    return response()->json([
            'status' => true,
            'message' => 'data fetched',
            'data' => new ShowVendorResource($vendor)
        
        ]);

    }

    public function getFilter() {
        $vendors = Vendor::all();
        $categories = Category::all();
        
        // Create a list of discounts with id and discount value
        $discountList = $vendors->map(function($vendor) {
            return [
                'id' => $vendor->id,
                'discount' => $vendor->discount
            ];
        })->values()->all();
        
        return response()->json([
            'status' => true,
            'message' => 'data fetched successfully',
            'data' => [
                'categories' => CategoryResource::collection($categories),
                'vendors' => VendorResource::collection($vendors),
                'discounts' => $discountList
            ],
        ]);
    }

    public function search(Request $request)
    {
        $params = $request->validate([
            'name' => 'nullable|string|max:255',
            'category_id' => 'nullable|integer|exists:categories,id',
            'latitude' => 'nullable|numeric|required_with:longitude',
            'longitude' => 'nullable|numeric|required_with:latitude',
            'radius' => 'nullable|numeric|min:0.1|max:100',
            'discount' => 'nullable',
        ]);
        
        $vendors = $this->vendorRepository->search($params);
        
        // Load relationships if not already loaded
        if (!$vendors->first() || !$vendors->first()->relationLoaded('categories')) {
            $vendors->load('categories');
        }
        
        // Make sure we only load active branches
        if (!isset($params['latitude']) || !isset($params['longitude'])) {
            $vendors->load(['branches' => function($query) {
                $query->where('is_active', 1);
            }]);
        }
        
       
        
           return response()->json([
            'status' => true,
            'message' => 'data fetched',
            'data' => VendorResource::collection($vendors)
        
        ]);
    }

}
