<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\CategoryResource;
use App\Repositories\Contracts\CategoryRepositoryInterface;

class CategoryController extends Controller
{

    protected $categoryRepository;
    
    /**
     * CategoryController constructor.
     * 
     * @param CategoryRepositoryInterface $categoryRepository
     */
    public function __construct(CategoryRepositoryInterface $categoryRepository)
    {
        $this->categoryRepository = $categoryRepository;
    }
    
    public function index(Request $request)
    {
        $query = $request->query();
        
        // Search & sort parameters
        $search = $query['search'] ?? null;
        $sortBy = $query['sort_by'] ?? 'created_at';
        $sortDirection = $query['sort_direction'] ?? 'desc';
        $perPage = $query['per_page'] ?? 15;
        
        // Get categories with search & sort
        $categories = $this->categoryRepository->getCategories($search, $sortBy, $sortDirection, $perPage);
        
        return response()->json([
            'status' => true,
            'message' => 'Data fetched successfully',
            'data' => CategoryResource::collection($categories)
        ]);
    }
}
